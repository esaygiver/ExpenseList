//
//  EntryViewController.swift
//  Project1Esay
//
//  Created by admin on 8.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
//    @IBOutlet var importancePicker: UIPickerView!
//    @IBOutlet var impLabel: UILabel!
    
//    var importanceLevelArray = ["Very High!!", "High!", "Medium", "Low"]
    
    public var toDoList: ToDoList?
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        field.becomeFirstResponder()
        field.delegate = self
//        importancePicker.dataSource = self
//        importancePicker.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        datePicker.setDate(Date(), animated: true)

    }
    
    @objc func saveButtonTapped() {
        if let text = field.text, !text.isEmpty {
            let date = datePicker.date
            
            realm.beginWrite()
                var toDoList = ToDoList()
                    toDoList.date = date
                    toDoList.title = text
                    toDoList.importance = false
            realm.add(toDoList)
            completionHandler?()
            try! realm.commitWrite()
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            print("add something")
        }
    }
}

//MARK: - TextField Delegate Method

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        return true
    }
}

////MARK: - UIPickerView DataSource, Delegate Method
//
//extension EntryViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return importanceLevelArray.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return importanceLevelArray[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        impLabel.text = importanceLevelArray[row]
//    }
//}

