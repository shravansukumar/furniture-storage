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
    
    // MARK: - IBOutlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var addImageButton: UIButton!
    
    // MARK: - Constants and Variables
    var item: FurnitureItem?
    var count: Int = 1
    let realm = try! Realm()
    var imagePickerController = UIImagePickerController()
    var saveButton = UIBarButtonItem()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
        //addTextToImage()
    }
    
    // MARK: - Private Methods
    private func setupNavigation() {
        navigationItem.title = "Add Item"
        saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupViews() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        if let item = item {
            nameTextField.text = item.name
            typeTextField.text = item.type
            addImageButton.isHidden = true
            itemImageView.isHidden = false
            saveButton.isEnabled = false
        } else {
            descriptionTextView.text = "Enter description here"
            addImageButton.isHidden = false
            itemImageView.isHidden = true
            
        }
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
    
    // MARK: - IBActions
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
