//
//  ItemsViewController.swift
//  Esay ExpenseList
//
//  Created by admin on 5.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import CoreData

class ItemsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category? {
        didSet {
            getAllItems2()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelectionDuringEditing = false
        getAllItems2()

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Expense", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Expense", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
        
            let newItem = Item.init(context: self.context)
            newItem.name = textField.text!
            newItem.date = Date()
            newItem.parentCategory = self.selectedCategory
            self.items.append(newItem)
            self.saveItems2()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//MARK: - Data Manipulation Methods
    
    func saveItems2() {
        do {
            try context.save()
            getAllItems2()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteItems2(item: Item) {
        context.delete(item)
        saveItems2()
    }
    
    func createItem2(name: String) {
        let newItem = Item.init(context: context)
        newItem.name = name
        newItem.date = Date()
        saveItems2()
    }
    
    func getAllItems2(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    //MARK: - Delete-Scroll Part
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        deleteItems2(item: item)
    }
}


//MARK: - TableView DataSource Method

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if cell != nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = items[indexPath.row].date?.description(with: Locale(identifier: "tr_TR"))
        return cell
    }
}

//MARK: - TableView Delegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveItems2()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



