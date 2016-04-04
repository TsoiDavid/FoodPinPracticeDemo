//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simon Ng on 19/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {
    var name:String = ""
    var type:String = ""
    var location:String = ""
    var image:String = ""
    var isVisited:Bool = false
    var locationImage:UIImage? = nil
    
    init(name:String, type:String, location:String, image:String, isVisited:Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}