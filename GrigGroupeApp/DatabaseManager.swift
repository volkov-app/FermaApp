//
//  DatabaseManager.swift
//  GrigGroupeApp
//
//  Created by Алексей Волков on 12.11.2020.
//

import Foundation
import CoreData

class DatabaseManager {
    static var instance = DatabaseManager()
    
    func saveMeal(object: MealObject, completion: (_ finished: Bool) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let meal = Meal(context: manageContext)
        meal.name = object.name
        meal.price = Int16(object.price)
        meal.desc = object.descriptionOfMeal
        meal.imageName = object.imageName
        meal.isAdded = object.isAdded ?? false
        
        do {
            try manageContext.save()
            print("Data saved")
            completion(true)
        } catch  {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
    }
    
    func fetchData(completion: (_ finished: Bool, _ meals: [Meal]?) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        
        do {
            let meals = try manageContext.fetch(request) as! [Meal]
            print("Data fetched, no issue")
            completion(true, meals)
        } catch  {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false, nil)
        }
    }
    
    func updateMeal() {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        do {
            try manageContext.save()
            print("Date saved")
        } catch  {
            print("Failed to save data: ", error.localizedDescription)
        }
        
    }
}
