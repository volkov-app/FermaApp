//
//  Category.swift
//  GrigGroupeApp
//
//  Created by Alex Rudoi on 15/12/20.
//

import UIKit

struct Category {
    var name: String
    var categoryImage: UIImage
    
    init(_ image: UIImage, _ name: String) {
        self.name = name
        categoryImage = image
    }
}
