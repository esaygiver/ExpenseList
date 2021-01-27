//
//  Shopping+CoreDataProperties.swift
//  Project1Esay
//
//  Created by admin on 6.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//
//

import Foundation
import CoreData


extension Shopping {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shopping> {
        return NSFetchRequest<Shopping>(entityName: "Shopping")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var price: Double

}
