//
//  FurnitureItem.swift
//  furniture-storing
//
//  Created by Shravan Sukumar on 10/02/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import Foundation
import RealmSwift

class FurnitureItem: Object {
   // @objc dynamic var image: UIImage = UIImage()
    @objc dynamic var itemNumber: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var itemDescription: String? = ""
    @objc dynamic var dateAdded: Date = Date()
    
    
    override static func primaryKey() -> String? {
        return "itemNumber"
    }
    

    convenience init(itemNumber: Int, name: String, type: String, description: String?) {
        self.init()
        
        self.itemNumber = itemNumber
        self.name = name
        self.type = type
        self.itemDescription = description
    }
}
