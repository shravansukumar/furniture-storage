//
//  Utility.swift
//  furniture-storing
//
//  Created by Shravan Sukumar on 12/02/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import Foundation
import UIKit


class Utility {
    class func saveImage(imageName: String, image: UIImage) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        print(imagePath)
        let data = UIImageJPEGRepresentation(image, 1)
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    class func getImage(imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        } else {
            print("some issue with the image")
        }
        return nil
    }
    
}
