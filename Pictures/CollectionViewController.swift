//
//  CollectionViewController.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

final class CollectionViewController: UIViewController  {
    
    var viewModel: CollectionViewModelProtocol
    
    
    private lazy var collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        let itemsOnScreen: CGFloat = 2
        var width = UIScreen.main.bounds.size.width
        width -= (14 * (itemsOnScreen + 1)) // Space between cells.
        var cellWidth = width / itemsOnScreen
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth )
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.dataSource = self
        return collectionView
    }()
    
    init(viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellItemViewModel = viewModel.sections[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellItemViewModel.reuseIndetifier, for: indexPath)
        cellItemViewModel.setup(cell, in: collectionView, at: indexPath)
        cell.backgroundColor = UIColor.green // just to test
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.viewModel.sections[indexPath.section]
        guard let cellModel = section.model(for: kind) else {
            return UICollectionReusableView()
        }
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellModel.reuseIndetifier, for: indexPath)
        cellModel.setup(reusableView, in: collectionView, at: indexPath)
        return reusableView
    }
    
    
    
}
