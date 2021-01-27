//
//  FirstViewController.swift
//  Project1Esay
//
//  Created by admin on 9.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var expenseListButton: UIButton!
    @IBOutlet weak var toDoListButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expenseListButton.layer.masksToBounds = false
        expenseListButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        expenseListButton.layer.shadowOpacity = 1.0
        expenseListButton.layer.shadowRadius = expenseListButton.frame.size.height / 2
        expenseListButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        expenseListButton.layer.cornerRadius = expenseListButton.frame.size.height / 2
        
        toDoListButton.layer.masksToBounds = false
        toDoListButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        toDoListButton.layer.shadowOpacity = 1.0
        toDoListButton.layer.shadowRadius = expenseListButton.frame.size.height / 2
        toDoListButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        toDoListButton.layer.cornerRadius = expenseListButton.frame.size.height / 2
        
    }
    

}
