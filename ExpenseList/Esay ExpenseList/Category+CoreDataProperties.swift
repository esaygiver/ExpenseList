//
//  Category+CoreDataProperties.swift
//  Esay ExpenseList
//
//  Created by admin on 4.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?
    @NSManaged public var items: Item?

}
