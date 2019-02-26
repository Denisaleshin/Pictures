//
//  AsyncDownload.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/26/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation
import UIKit

class AsyncDownload: Operation {
    
    let urlString: String
    var image: UIImage?
    
    
    
     init(url: String) {
        self.urlString = url
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        let url = URL(stringLiteral: urlString)
        let data = try? Data(contentsOf: url)
        guard !isCancelled, let validData = data  else { return }
        image = UIImage(data: validData)
    }
    
    
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("\(value) is an invalid url")
        }
        self = url
    }
    
    
}
