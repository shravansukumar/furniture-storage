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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupNavigation() {
        navigationItem.title = "Add Item"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        
    }

}
