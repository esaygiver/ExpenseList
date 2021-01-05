//
//  Item+CoreDataProperties.swift
//  Esay ExpenseList
//
//  Created by admin on 5.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String
    @NSManaged public var parentCategory: Category?

}
