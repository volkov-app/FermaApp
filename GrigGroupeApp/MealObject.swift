//
//  MealObject.swift
//  GrigGroupeApp
//
//  Created by Алексей Волков on 12.11.2020.
//

import UIKit

//делаем объект
class MealObject: NSObject {
    var name = "Имя блюда"
    var price = 100
    var descriptionOfMeal = "Описание"
    var imageName = "GrigGroup"
    var category = "category"

    
    //свойство на явность элементов в корзине
    var isAdded: Bool? = false
    var count = 1
    
    
    init(name: String, price: Int, description: String, image: String, isAdded: Bool?, category: String) {
        super.init() //Объявляет что это самый главный init
        
        self.name = name
        self.price = price
        self.descriptionOfMeal = description
        self.imageName = image
        self.category = category
        self.isAdded = isAdded ?? false
    }
}
