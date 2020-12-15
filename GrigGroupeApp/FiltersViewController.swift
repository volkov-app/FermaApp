//
//  FiltersViewController.swift
//  GrigGroupeApp
//
//  Created by Alex Rudoi on 13/12/20.
//

import UIKit
import SwiftCSV

class FiltersViewController: UIViewController {

    @IBOutlet weak var tv: UITableView!
    
    var categories: [Category] = [Category(UIImage(named: "pizzaIcon")!, "Пицца"),
                                  Category(UIImage(named: "cheaseIcon")!, "Сыры & Мясо"),
                                  Category(UIImage(named: "zakuskiIcon")!, "Закуски"),
                                  Category(UIImage(named: "salatIcon")!, "Салаты"),
                                  Category(UIImage(named: "yagodiIcon")!, "Ягоды & Фрукты"),
                                  Category(UIImage(named: "hlebIcon")!, "Брускетты на нашей чиабатте"),
                                  Category(UIImage(named: "garnieIcon")!, "Гарниры & Овощи"),
                                  Category(UIImage(named: "desertIcon")!, "Десерты"),
                                  Category(UIImage(named: "aquariumIcon")!, "Аквариум"),
                                  Category(UIImage(named: "supIcon")!, "Супы"),
                                  Category(UIImage(named: "meatIcon")!, "Мясо"),
                                  Category(UIImage(named: "fishIcon")!, "Рыба"),
                                  Category(UIImage(named: "seafoodIcon")!, "Морепродукты"),
                                  Category(UIImage(named: "vipechkaIcon")!, "Выпечка"),
                                  Category(UIImage(named: "desertIcon")!, "Десерт"),
                                  Category(UIImage(named: "otherIcon")!, "Другое")]
    
    var mealsCoreData: [Meal] = []
    var splitedMeals: [[Meal]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        
        fecthData()
        mealsCoreData.forEach { (meal) in
            DatabaseManager.instance.deleteMeal(meal: meal)
        }
        createNewMeals()
        fecthData()
    }
    
    func fecthData() {
            DatabaseManager.instance.fetchData { (done, meals) in
                if done, let allMeal = meals {
                    
                    self.mealsCoreData = allMeal
                    self.splitedMeals = splitMealsToSections(self.mealsCoreData)
                }
            }
            tv.reloadData()
        }
    
    func createNewMeals() {
        
        let mealsArray = getArray()
        mealsArray.forEach { (meal) in
            DatabaseManager.instance.saveMeal(object: MealObject(name: meal["name"]!,
                                                                 price: Int(meal["price"]!)!,
                                                                 description: meal["description"]!,
                                                                 image: meal["id"]!,
                                                                 isAdded: nil,
                                                                 category: meal["category"]!))
            { (done) in
                if done {
                    print("All is okay")
                } else {
                    print("something wrong")
                }
            }
        }
    }
    
    func getArray() -> [[String: String]] {
        
        //Массив из обьектов с их параметрами
        var dataArray : [[String: String]] = []
        do {
            var csvFile: CSV?
            if let path = Bundle.main.path(forResource: "menu", ofType: "csv") {
                let url = URL(fileURLWithPath: path)
                csvFile = try CSV(url: url)
            }
            dataArray = csvFile?.namedRows ?? []
        } catch  {
            print(error.localizedDescription)
        }
        
        return dataArray
    }
    
    func splitMealsToSections(_ mealsArray: [Meal]) -> [[Meal]] {
        var result: [[Meal]] = []
        
        let soupMeals = mealsArray.filter {
            $0.category == "ПИЦЦА"
        }
        result.append(soupMeals)
        let cheeseMeetMeals = mealsArray.filter {
            $0.category == "СЫРЫ & МЯСО"
        }
        result.append(cheeseMeetMeals)
        let eats = mealsArray.filter {
            $0.category == "ЗАКУСКИ"
        }
        result.append(eats)
        let salats = mealsArray.filter {
            $0.category == "САЛАТЫ"
        }
        result.append(salats)
        let fruits = mealsArray.filter {
            $0.category == "ЯГОДЫ & ФРУКТЫ"
        }
        result.append(fruits)
        let bruskets = mealsArray.filter {
            $0.category == "БРУСКЕТТЫ НА НАШЕЙ ЧИАБАТТЕ"
        }
        result.append(bruskets)
        let vedjetabls = mealsArray.filter {
            $0.category == "ГАРНИРЫ & ОВОЩИ"
        }
        result.append(vedjetabls)
        let diserts = mealsArray.filter {
            $0.category == "ДЕСЕРТЫ"
        }
        result.append(diserts)
        let aquarium = mealsArray.filter {
            $0.category == "АКВАРИУМ"
        }
        result.append(aquarium)
        let soups = mealsArray.filter {
            $0.category == "СУПЫ"
        }
        result.append(soups)
        let meats = mealsArray.filter {
            $0.category == "МЯСО"
        }
        result.append(meats)
        let fishes = mealsArray.filter {
            $0.category == "РЫБА"
        }
        result.append(fishes)
        let seaFood = mealsArray.filter {
            $0.category == "МОРЕПРОДУКТЫ"
        }
        result.append(seaFood)
        let bake = mealsArray.filter {
            $0.category == "ВЫПЕЧКА"
        }
        result.append(bake)
        let desert = mealsArray.filter {
            $0.category == "ДЕСЕРТ"
        }
        result.append(desert)
        
        return result
    }

}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitedMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! MenuTableViewCell
        
        cell.config(name: categories[indexPath.row].name, image: categories[indexPath.row].categoryImage)
        
        return cell
    }
    
    
}
