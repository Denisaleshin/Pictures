//
//  ViewController.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController {
    
    @IBOutlet weak var getPicturesButton: UIButton! // to customize this button in future
    var viewModel: InitialViewModelProtocol = InitialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getPicturesButtonPressed(_ sender: Any) {
        self.viewModel.getUrlList { [weak self] result in
            switch result {
            case .success(_):
                let collectionViewModel = self?.viewModel.getCollectionViewModel() ?? CollectionViewModel()
                let colectionViewcontroller = CollectionViewController(viewModel: collectionViewModel)
                navigationController?.pushViewController(colectionViewcontroller, animated: true)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
}


