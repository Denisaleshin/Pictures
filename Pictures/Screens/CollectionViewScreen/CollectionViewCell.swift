//
//  CollectionViewCell.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/22/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 5),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        Label.makeStandartLabel()
    }()
    
    lazy var priceLabel: UILabel = {
        Label.makeStandartLabel()
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.red
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
    
    func setupContetnt(image: UIImage) {
        imageView.image = image
    }
}
