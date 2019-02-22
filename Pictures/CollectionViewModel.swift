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
    func setupContetnt(imageURL: String)
}




protocol SectionViewModelProtocol {
    var items: [CellItemProtocol] { get }
    func model(for elementOfKind: String) -> CellItemProtocol?
}



protocol CellItemProtocol {
    var reuseIndetifier: String { get }
    func setup(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath)
}



class CollectionViewCell: UICollectionViewCell {
    var imageURL: String?
    lazy var titleLabel: UILabel = {
        Label.makeStandartLabel()
    }()
    
    lazy var priceLabel: UILabel = {
        Label.makeStandartLabel()
    }()
    
    lazy var imageViev: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

extension CollectionViewCell: Contentable {
    func setupContetn(title: String) {
        
        self.titleLabel.text = title
    }
    
    func setupContetnt(price: Int) {
        self.priceLabel.text = "\(price)"
    }
    
    func setupContetnt(imageURL:String) {
        self.imageURL = imageURL
    }
}

struct Label {
    static func makeStandartLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.black
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
