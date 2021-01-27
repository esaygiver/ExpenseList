//
//  CoreDataMethods.swift
//  Project1Esay
//
//  Created by admin on 6.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class CoreDataMethods {
    
    var shopList = [Shopping]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var tableView: UITableView!
    
     func loadItems() {
           do {
               shopList = try context.fetch(Shopping.fetchRequest())
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           } catch {
               print("We got an error at loading items!")
           }
       }
       
       func saveItems() {
           do {
               try context.save()
               loadItems()
           } catch {
               print("We catch an error at saving items!")
           }
       }
       
       func createItems(title: String, price: String) {
           let newItem = Shopping(context: self.context)
           newItem.title = title
           newItem.price = price
           newItem.date = Date()
           saveItems()
       }
       
       func deleteItems(item: Shopping) {
           context.delete(item)
           saveItems()
       }
       
       func updateItem(item: Shopping, title: String, price: String) {
           item.title = title
           item.price = price
           item.date = Date()
           saveItems()
       }
}
