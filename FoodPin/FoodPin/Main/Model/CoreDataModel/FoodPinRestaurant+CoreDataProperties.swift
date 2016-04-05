//
//  FoodPinRestaurant+CoreDataProperties.swift
//  FoodPin
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 AppCoda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FoodPinRestaurant {

    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!

}
