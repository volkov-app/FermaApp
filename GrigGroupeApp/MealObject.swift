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

    
    //свойство на явность элементов в корзине
    var isAdded: Bool? = false
    
    
    init(name: String, price: Int, description: String, image: String, isAdded: Bool?) {
        super.init() //Объявляет что это самый главный init
        
        self.name = name
        self.price = price
        self.descriptionOfMeal = description
        self.imageName = image
        
        self.isAdded = isAdded ?? false
    }
}
