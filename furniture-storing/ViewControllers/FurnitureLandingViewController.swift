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
                    
                    tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) },
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) },
                                         with: .automatic)
                    
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
    
    
    // MARK: - Private Methods
    private func setupNavigation() {
        navigationItem.title = "Furniture List"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNib(viewClass: FurnitureLandingTableViewCell.self)
    }
    
    // MARK: - Public Methods
    @objc func addButtonTapped() {
        pushToAddItemViewController()
    }
    
    func manange(visibility: Bool) {
        emptyTextLabel.isHidden = visibility
        tableView.isHidden = !visibility
    }
    
    func pushToAddItemViewController(for index: IndexPath? = nil) {
        let itemViewController = self.storyboard?.instantiateViewController(withIdentifier: "addItemViewController") as! AddItemViewController
        if let furnitures = furnitureItems {
            if let indexPath = index {
                itemViewController.item = furnitureItems?[indexPath.row]
                itemViewController.viewMode = true
            }
            itemViewController.count = furnitures.count + 1
        }
        navigationController?.pushViewController(itemViewController, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension FurnitureLandingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = furnitureItems {
            if items.count == 0 {
                manange(visibility: false)
            } else {
                manange(visibility: true)
            }
            return items.count
        } else {
            manange(visibility: false)
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
        pushToAddItemViewController(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

