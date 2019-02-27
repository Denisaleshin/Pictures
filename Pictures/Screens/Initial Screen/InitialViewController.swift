//
//  ViewController.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var getPicturesButton: UIButton!
    var viewModel: InitialViewModelProtocol = InitialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView.isHidden = true
    }
    
    @IBAction func getPicturesButtonPressed(_ sender: Any) {
        // connection check should be here something like: guard isConected else { showConnectionErrorTouser() ; return }
        getPicturesButton.isHidden = true
        spinnerView.isHidden = false
        spinnerView.startAnimating()
        self.viewModel.getUrlList { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.getPicturesButton.isHidden = false
                    self?.spinnerView.isHidden = true
                    guard let collectionViewModel = self?.viewModel.getCollectionViewModel() else { return }
                    let colectionViewcontroller = CollectionViewController(viewModel: collectionViewModel)
                    self?.navigationController?.pushViewController(colectionViewcontroller, animated: true)
                }
            case let .failure(error):
                print(error)
            }
        }
        spinnerView.stopAnimating()
    }
    
    
}


