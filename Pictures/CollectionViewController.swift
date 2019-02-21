//
//  CollectionViewController.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController  {
    
    var viewModel: CollectionViewModelProtocol
    
    private lazy var collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 7, left: 15, bottom: 4, right: 15)
        layout.minimumLineSpacing = 10;
        let itemsOnScreen: CGFloat = 2
        var width = UIScreen.main.bounds.size.width
        width -= (14 * (itemsOnScreen + 1)) // Space between cells.
        var cellWidth = width / itemsOnScreen
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth )
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.delegate = self
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        // Do any additional setup after loading the view.
    }

   
    
}

extension CollectionViewController: UICollectionViewDelegate {
   

}
extension CollectionViewController: UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 20
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
       cell.backgroundColor = UIColor.green
        
        return cell
    }

    
}
