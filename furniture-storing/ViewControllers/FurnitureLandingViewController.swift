//
//  FurnitureLandingViewController.swift
//  furniture-storing
//
//  Created by Shravan Sukumar on 10/02/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import UIKit
import RealmSwift

class FurnitureLandingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var emptyTextLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Constants and Variables
    let realm = try! Realm()
    var token: NotificationToken?
    var selectedIndexPath : IndexPath!
    let identifier = "AddItemSegueIdentifier"
    var furnitureItems: Results<FurnitureItem>? {
        didSet {
            token = furnitureItems?.observe {[weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                
                switch changes {
                case .initial:
                    tableView.reloadData()
                    break
                case .update(let results, let deletions, let insertions, let modifications):
                    
                    tableView.beginUpdates()
                    
                    //re-order repos when new pushes happen
                    tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) },
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) },
                                         with: .automatic)
                    
                    //flash cells when repo gets more stars
                    for row in modifications {
                        let indexPath = IndexPath(row: row, section: 0)
                        let repo = results[indexPath.row]
                        if let cell = tableView.cellForRow(at: indexPath) as? FurnitureLandingTableViewCell {
                           cell.setupCell(for: repo)
                        } else {
                            print("cell not found for \(indexPath)")
                        }
                    }
                    
                    tableView.endUpdates()
                    break
                case .error(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
        furnitureItems = realm.objects(FurnitureItem.self).sorted(byKeyPath: "itemNumber", ascending: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            if let addItemViewController = segue.destination as? AddItemViewController {
                if let furnitures = furnitureItems {
                    if let index = selectedIndexPath {
                        addItemViewController.item = furnitures[index.row]
                    }
                    addItemViewController.count = furnitures.count + 1
                }
            }
            
        }
    }
    
    // MARK: - Private Methods
    private func setupNavigation() {
        navigationItem.title = "Furniture List"
        navigationController?.navigationBar.tintColor = .white
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNib(viewClass: FurnitureLandingTableViewCell.self)
    }
    
    @objc func addButtonTapped() {
        performSegue(withIdentifier: identifier, sender: self)
    }
}

// MARK: - UITableViewDataSource
extension FurnitureLandingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = furnitureItems {
            return items.count
        } else {
            //emptyTextLabel.isHidden = false
        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = furnitureItems![indexPath.row]
        let cell = tableView.dequeueReusableCell(tableViewCellClass: FurnitureLandingTableViewCell.self)
        cell.setupCell(for: item)
        return cell 
    }
}

extension FurnitureLandingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
      //  performSegue(withIdentifier: identifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

