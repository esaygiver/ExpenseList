//
//  Shopping+CoreDataProperties.swift
//  
//
//  Created by admin on 8.01.2021.
//
//

import Foundation
import CoreData


extension Shopping {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shopping> {
        return NSFetchRequest<Shopping>(entityName: "Shopping")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: String?
    @NSManaged public var title: String?

}
