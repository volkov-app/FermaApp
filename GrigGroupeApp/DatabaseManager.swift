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
    
    //функция создания нового объекта
    func saveMeal(object: MealObject, completion: (_ finished: Bool) -> ()) {
        //передаем данные и проверяем на наличие ошибок
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //Объявляю свойство парраметров
        let meal = Meal(context: manageContext)
        meal.name = object.name
        meal.price = Int16(object.price) // выбираем 16 чтобы не занимать много памяти
        meal.desc = object.descriptionOfMeal
        meal.imageName = object.imageName
        meal.isAdded = object.isAdded ?? false
        
        
        //Пытаемся сохранить контекст
        do {
            try manageContext.save()
            print("Data saved")
            completion(true)
        } catch  {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
    }
    
    
    //функция получения данных
    func fetchData(completion: (_ finished: Bool, _ meals: [Meal]?) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        
        //Обновляем массив с уже сделанными изменениями (если они были)
        do {
            let meals = try manageContext.fetch(request) as! [Meal]
            print("Data fetched, no issue")
            completion(true, meals)
        } catch  {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false, nil)
        }
    }
    
    //Функция обновления
    func updateMeal() {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        do {
            try manageContext.save()
            print("Date saved")
        } catch  {
            print("Failed to save data: ", error.localizedDescription)
        }
        
    }
    
    func deleteMeal(meal: Meal) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(meal)
        do {
            try managedContext.save()
            print("Data deleted")
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
        }
    }
}
