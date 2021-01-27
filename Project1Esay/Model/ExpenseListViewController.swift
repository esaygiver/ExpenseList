//
//  ViewController.swift
//  Project1Esay
//
//  Created by admin on 6.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class ExpenseListViewController: UIViewController {
    
    var shopList = [Shopping]()
    @IBOutlet var tableView: UITableView!
    fileprivate let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadItems()
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
    }
    
    //MARK: - CoreData Manipulation Methods
    
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
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        var priceField = UITextField()
        let alert = UIAlertController(title: "Add New Shopping Expense", message: "", preferredStyle: .alert)
        alert.addTextField { (field) in
            field.placeholder = "Title of Expense"
            field.autocapitalizationType = UITextAutocapitalizationType.words
            textField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Price of Expense"
            priceField = field
        }
        alert.addAction(UIAlertAction(title: "Add!", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            guard let price = alert.textFields?.last?.text, !text.isEmpty else { return }
            self.createItems(title: text, price: price)
        }))
        present(alert, animated: true)
    }
}

//MARK: - TableView Delegate Method

extension ExpenseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var textField = UITextField()
        var priceField = UITextField()
        let item = shopList[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edition", message: "Edit your expense", preferredStyle: .alert)
            alert.addTextField { (firstField) in
                firstField.placeholder = "Edit Title"
                firstField.clearsOnBeginEditing = true
                firstField.autocapitalizationType = UITextAutocapitalizationType.words
                textField = firstField
            }
            alert.addTextField { (secondField) in
                secondField.placeholder = "Edit Price"
                secondField.clearsOnBeginEditing = true
                priceField = secondField
            }
            alert.textFields?.first?.text = item.title
            alert.textFields?.last?.text = item.price
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
                guard let newTitle = alert.textFields?.first?.text else { return }
                guard let newPrice = alert.textFields?.last?.text else { return }
                self?.updateItem(item: item, title: newTitle, price: newPrice)
            }))
            self.present(alert, animated: true)
        }))
        
//        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
//            self.deeleteItems(item: item)
//        }))
        
        present(sheet, animated: true)
    }
    
//MARK: - Delete-Scroll Part
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let item = shopList[indexPath.row]
            deleteItems(item: item)
        }
    }
 
//MARK: - TableView DataSource Method
    
    extension ExpenseListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return shopList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var createdAt = shopList[indexPath.row].date!.getFormattedDate()
            var price = shopList[indexPath.row].price!
            cell.textLabel?.text = shopList[indexPath.row].title
            cell.detailTextLabel?.text = "\(price)₺ , \(createdAt)"
            return cell
        }
    }
    
extension Date {
    func getFormattedDate(format: String = "d MMMM EEEE") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.locale = Locale(identifier: "tr_TR")
        return dateformat.string(from: self)
    }
}






