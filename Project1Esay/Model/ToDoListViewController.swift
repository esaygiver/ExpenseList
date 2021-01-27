//
//  ToDoListViewController.swift
//  Project1Esay
//
//  Created by admin on 7.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import RealmSwift
import UIKit

class ToDoListViewController: UIViewController {
    
    private let realm = try! Realm()
    private var toDoList = [ToDoList]()
    public var completionHandler: (() -> Void)?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoList = realm.objects(ToDoList.self).map({ $0 })
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else { return }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        vc.title = "Add!"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
        toDoList = realm.objects(ToDoList.self).map({ $0 })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//MARK: - TableView DataSource Method

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let myPath = toDoList[indexPath.row]
        cell.accessoryType = myPath.importance ? .checkmark : .none
        cell.textLabel?.text = myPath.title
        cell.detailTextLabel?.text = myPath.date.getFormattedDate()
        return cell
    }
}

//MARK: - TableView DataSource Method

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let myPath = toDoList[indexPath.row]
        realm.beginWrite()
        myPath.importance = !myPath.importance
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        try! realm.commitWrite()
    }
    
//MARK: - Delete-Scroll Part

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        realm.beginWrite()
        realm.delete(toDoList[indexPath.row])
        DispatchQueue.main.async {
            self.toDoList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        try! realm.commitWrite()
    
    }
}


