//
//  ToDoList+CoreDataProperties.swift
//  Project1Esay
//
//  Created by admin on 6.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var title: String?
    @NSManaged public var done: Bool

}
