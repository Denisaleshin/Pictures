//
//  CollectionViewModel.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation
import UIKit

protocol Contentable {
    func setupContetn(title: String)
    func setupContetnt(price: Int)
    func setupContetnt(image: UIImage)
}

protocol SectionViewModelProtocol {
    var items: [CellItemProtocol] { get }
    func model(for elementOfKind: String) -> CellItemProtocol?
}

protocol CellItemProtocol {
    var reuseIndetifier: String { get }
    func setup(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath)
    func cancelDownloadingFor(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath)
}

struct Label {
    static func makeStandartLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.black // just to test
        return label
    }
}

protocol CollectionViewModelProtocol {
    var sections: [SectionViewModelProtocol] { get set }
}

final class CollectionViewModel: CollectionViewModelProtocol {
    var sections: [SectionViewModelProtocol]
    init(sections:[SectionViewModelProtocol] ) {
        self.sections = sections
    }
}
