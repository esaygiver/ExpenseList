////
////  ViewViewController.swift
////  Project1Esay
////
////  Created by admin on 8.01.2021.
////  Copyright © 2021 esaygiver. All rights reserved.
////
//
//import RealmSwift
//import UIKit
//
//class ViewViewController: UIViewController {
//
//    private var realm = try! Realm()
//    public var item: ToDoList?
//    public var deletionHandler: (() -> Void)?
//    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var dateLabel: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        titleLabel.text = item?.title
//        dateLabel.text = item?.date.getFormattedDate()
//
////        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
//      }
//
////    @objc func deleteButtonTapped() {
////        guard let myItem = self.item else { return }
////        try! realm.beginWrite()
////        realm.delete(myItem)
////        try! realm.commitWrite()
////        deletionHandler?()
////        navigationController?.popToRootViewController(animated: true)
////
////    }
//
//   }
