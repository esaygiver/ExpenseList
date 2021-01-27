//
//  ToDoList.swift
//  Project1Esay
//
//  Created by admin on 8.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import RealmSwift
import UIKit

class ToDoList: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var importance: Bool = false

}
