//
//  ViewController.swift
//  Esay ExpenseList
//
//  Created by admin on 4.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categories = [Category]()
    @IBOutlet var tableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        getAllItems()
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    @IBAction private func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Expense Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Add new Exp"
            textField = field
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                print("we got an error at adding closure")
                return
            }
            self.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    //MARK: - Core Data
    
    func saveItems() {
        do {
            try context.save()
            getAllItems()
        } catch {
            print("We got an error at saving items, \(error.localizedDescription)")
        }
    }
    
    func deleteItems(item: Category) {
        context.delete(item)
        saveItems()
    }
    
    func getAllItems() {
        do {
            categories = try context.fetch(Category.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("We got an error at getting all items, \(error.localizedDescription)")
        }
    }
    
    func createItem(name: String) {
        let newItem = Category.init(context: context)
        newItem.name = name
        saveItems()
    }
    
//MARK: - Delete-Scroll Part

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = categories[indexPath.row]
        deleteItems(item: item)
    }
}
//MARK: - TableView DataSource Method

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}

//MARK: - TableView Delegate

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destinationVC = segue.destination as! ItemsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
}






