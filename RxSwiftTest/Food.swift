//
//  Food.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 03/11/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import UIKit

struct Food {
    let name: String
    let flickrID: String
    var image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
        image = UIImage(named: flickrID)
    }
}

extension Food: CustomStringConvertible {
    var description: String {
        return "\(name): flickr.com/\(flickrID)"
    }
}
