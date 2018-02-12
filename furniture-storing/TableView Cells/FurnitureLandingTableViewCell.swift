//
//  FurnitureLandingTableViewCell.swift
//  furniture-storing
//
//  Created by Shravan Sukumar on 10/02/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import UIKit

class FurnitureLandingTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(for item: FurnitureItem) {
        nameLabel.text = item.name
        typeLabel.text = item.type
        let image = Utility.getImage(imageName: "image\(item.itemNumber)")
        if let image = image {
            itemImageView.image = image
        } else {
            itemImageView.isHidden = true
        }
    }
    
}
