//
//  AddItemViewController.swift
//  furniture-storing
//
//  Created by Shravan Sukumar on 10/02/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    var item: FurnitureItem?
    var count: Int = 1
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Add Item"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupViews() {
        descriptionTextView.text = "Enter description here"
    }
    
    @objc func saveButtonTapped() {
        let item = FurnitureItem(itemNumber: count, name: nameTextField.text!, type: typeTextField.text!, description: descriptionTextView.text!)
        try! realm.write {
            self.realm.add(item, update: true)
        }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

}
