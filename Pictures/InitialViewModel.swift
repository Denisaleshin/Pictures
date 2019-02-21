//
//  InitialViewModel.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/21/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}

protocol CollectionViewModelProtocol { // here just to scip compiller warning, but will be needed in future
    
}

final class CollectionViewModel: CollectionViewModelProtocol { // here just to scip compiller warning, but will be needed in future
    
    
}

protocol InitialViewModelProtocol {
    var urls:[String]? { get }
    func getUrlList(completion:(Result<[String]>) -> ())
    func getCollectionViewModel() -> CollectionViewModelProtocol
}

final class InitialViewModel: InitialViewModelProtocol {
    var urls:[String]?
    
    func getUrlList(completion:(Result<[String]>) -> ()) {
        let mokedResult = ["string1", "string2"]
        completion(.success(mokedResult))
    }
    
    func getCollectionViewModel() -> CollectionViewModelProtocol {
       return CollectionViewModel()
    }
}
