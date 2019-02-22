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
    func getUrlList(completion:(Result<[Product]>) -> ())
    func getCollectionViewModel() -> CollectionViewModelProtocol
}

final class InitialViewModel: InitialViewModelProtocol {
    var products:[Product]?
    
    func getUrlList(completion:(Result<[Product]>) -> ()) {
        let a = Product(name: "name", price: 5, image: "image")
        let b = Product(name: "name", price: 5, image: "image")
        let c = Product(name: "name", price: 5, image: "image")
        let mokedResult = [a,b,c]
        products = mokedResult
        completion(.success(mokedResult))
    }
    
    func getCollectionViewModel() -> CollectionViewModelProtocol {
        let downLoadedProducts = products ?? []
        let items = downLoadedProducts.map { CellItem(content:$0) }
        let section = MokedSection(items: items)
        return CollectionViewModel(sections: [section])
    }
}

struct CellItem: CellItemProtocol {
    let content: Product
    let reuseIndetifier = "Cell"
    
    func cancelDownloadingFor(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath) {
        // I
    }
    
    func setup(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath) {
        guard let cell = cell as? Contentable else {
            return
        }
        cell.setupContetn(title: content.name)
        cell.setupContetnt(price: content.price)
        getImagefromURL { image in
            guard let cell = collectionView.cellForItem(at: indexPath) as? Contentable else {
                return
            }
            cell.setupContetnt(image: image)
        }
    }
    
    private func getImagefromURL(completion:((UIImage) -> ())) {
        
    }
}

struct Product: Codable {
    var name: String
    var price: Int
    var image: String
}

struct MokedSection: SectionViewModelProtocol {
    var items: [CellItemProtocol]
    func model(for elementOfKind: String) -> CellItemProtocol? {
        return nil
    }
}


