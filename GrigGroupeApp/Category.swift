//
//  Category.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/31/20.
//

import Foundation

class Category{
    let name: String
    let sortOrder: Int
    let imageURL: String

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
              let sortOrder = data["sortOrder"] as? String,
              let imageURL = data["image"] as? String else {
            return nil
        }
        self.name = name
        self.sortOrder = Int(sortOrder) ?? 0
        self.imageURL = imageURL
    }



}

