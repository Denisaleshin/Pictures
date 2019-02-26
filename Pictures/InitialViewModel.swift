//
//  InitialViewModel.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(Error?)
}

protocol InitialViewModelProtocol {
    var products:[Product]? { get }
    func getUrlList(completion:@escaping (Result<[Product]>) -> ())
    func getCollectionViewModel() -> CollectionViewModelProtocol
}

final class InitialViewModel: InitialViewModelProtocol {
    
    private let initialURL = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    var products:[Product]?
    
    func getUrlList(completion:@escaping (Result<[Product]>) -> ()) {
        NetworkManager.shared.fetchFrom(initialURL) { result  in
            switch result {
            case let .success(cellInfo):
                self.products = cellInfo
                completion(.success(cellInfo))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getCollectionViewModel() -> CollectionViewModelProtocol {
        let downLoadedProducts = products ?? []
        let items = downLoadedProducts.map { CellItem(content:$0) }
        let section = Section(items: items)
        return CollectionViewModel(sections: [section])
    }
}

struct CellItem: CellItemProtocol {
    let content: Product
    let reuseIndetifier = "Cell"
    private let downloadQueue = OperationQueue()
    
    func cancelDownloadingFor(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath) {
        // Nedd to implement fo canceling download when the cell goes out of the screen 
    }
    
    func setup(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath) {
        guard let cell = cell as? Contentable else {
            return
        }
        cell.setupContetn(title: content.name)
        cell.setupContetnt(price: content.price)
        getImagefromURL { image in
            DispatchQueue.main.async {
                guard let cell = collectionView.cellForItem(at: indexPath) as? Contentable else {
                    return
                }
                cell.setupContetnt(image: image)
            }
        }
    }
    
    private func getImagefromURL(completion:@escaping ((UIImage) -> ())) {
        // I've have chousen Operation class to download the images just to have ability cancel downloading when cell fades from screen
        
        let downloadOperation = AsyncDownload(url: content.image)
        downloadOperation.completionBlock = {
            guard let image = downloadOperation.image else { return }
            completion(image) }
        downloadQueue.addOperation(downloadOperation)
    }
}

struct ProductInfoInfo: Codable {
    var products: [Product]
    
}

struct Product: Codable {
    var name: String
    var price: Int
    var image: String
}

struct Section: SectionViewModelProtocol {
    var items: [CellItemProtocol]
    func model(for elementOfKind: String) -> CellItemProtocol? {
        return nil
    }
}


