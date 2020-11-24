//
//  MenuViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit
import CoreData
import SwiftCSV

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionsOfMeals: [[Meal]] = []
    var mealsCoreData: [Meal] = []
    
    var meals: [[String: String]] = []
    
    
    
    func splitMealsToSections(_ mealsArray: [Meal]) -> [[Meal]] {
        var result: [[Meal]] = []
        
        let soupMeals = mealsArray.filter {
            $0.category == "ПИЦЦА"
        }
        let cheeseMeetMeals = mealsArray.filter {
            $0.category == "СЫРЫ & МЯСО"
        }
        
        let eats = mealsArray.filter {
            $0.category == "ЗАКУСКИ"
        }
        let salats = mealsArray.filter {
            $0.category == "САЛАТЫ"
        }
        let fruits = mealsArray.filter {
            $0.category == "ЯГОДЫ & ФРУКТЫ"
        }
        let bruskets = mealsArray.filter {
            $0.category == "БРУСКЕТТЫ НА НАШЕЙ ЧИАБАТТЕ"
        }
        let vedjetabls = mealsArray.filter {
            $0.category == "ГАРНИРЫ & ОВОЩИ"
        }
        let diserts = mealsArray.filter {
            $0.category == "ДЕСЕРТЫ"
        }
        let aquarium = mealsArray.filter {
            $0.category == "АКВАРИУМ"
        }
        let soups = mealsArray.filter {
            $0.category == "СУПЫ"
        }
        let meats = mealsArray.filter {
            $0.category == "МЯСО"
        }
        let fishes = mealsArray.filter {
            $0.category == "РЫБА"
        }
        let seaFood = mealsArray.filter {
            $0.category == "МОРЕПРОДУКТЫ"
        }
        let bake = mealsArray.filter {
            $0.category == "ВЫПЕЧКА"
        }
        let desert = mealsArray.filter {
            $0.category == "ДЕСЕРТ"
        }
        
        
        
        
        
        
        
        
        
        
        
        result.append(soupMeals)
        result.append(cheeseMeetMeals)
        result.append(eats)
        result.append(salats)
        result.append(fruits)
        result.append(bruskets)
        result.append(vedjetabls)
        result.append(diserts)
        result.append(aquarium)
        result.append(soups)
        result.append(meats)
        result.append(fishes)
        result.append(bake)
        result.append(desert)
        
        
        //print(soupMeals)
        return result
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
    
    //сотрируем оставляя только отсортированное
    func splitMeals(_ meals: [Meal]) -> [Meal] {
        var result: [Meal] = []
        
        //Сюда будем записывать отфильтрованное блюдо
        let unaddedMeal = meals.filter {
            $0.isAdded == false // $0. проход по каждому элементу
        }
        
        result.append(contentsOf: unaddedMeal)
        
        return result
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fecthData() //чтобы обновлялось каждый раз как заходим на экран
    }
    
    
    func fecthData() {
        DatabaseManager.instance.fetchData { (done, meals) in
            if done, let allMeal = meals {
                self.mealsCoreData = splitMeals(allMeal)
                self.sectionsOfMeals = splitMealsToSections(self.mealsCoreData)
            }
        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fecthData()
//        fromCSVToArray()
        
        // чтобы обновить список нужно раскоментить а потом закрыть
       mealsCoreData.forEach { (meal) in
            DatabaseManager.instance.deleteMeal(meal: meal)
        }
//
//
        createNewMeals()
//
//
        fecthData()
    }
    
}

func getArray() -> [[String: String]] {
    
    //Массив из обьектов с их параметрами
    var dataArray : [[String: String]] = []
    
    
    do {
        
        let csvFile: CSV = try CSV(url: URL(fileURLWithPath: "/Users/volkov/FermaApp/GrigGroupeApp/menu.csv"))
        dataArray = csvFile.namedRows
    } catch  {
        
        print(error.localizedDescription)
    }
    
    return dataArray
}

//Показываем колличество клеток
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return sectionsOfMeals[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsOfMeals.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Pizza"
        case 1:
            return "СЫРЫ & МЯСО"
        case 2:
            return "ЗАКУСКИ"
        case 3:
            return "САЛАТЫ"
        case 4:
            return "ЯГОДЫ & ФРУКТЫ"
        case 5:
            return "БРУСКЕТТЫ НА НАШЕЙ ЧИАБАТТЕ"
        case 6:
            return "ГАРНИРЫ & ОВОЩИ"
        case 7:
            return "ДЕСЕРТЫ"
        case 8:
            return "АКВАРИУМ"
        case 9:
            return "СУПЫ"
        case 10:
            return "МЯСО"
        case 11:
            return "РЫБА"
        case 12:
            return "МОРЕПРОДУКТЫ"
        case 13:
            return "ВЫПЕЧКА"
        case 14:
            return "ДЕСЕРТ"
        default:
            return "Other"
        }
    }
    
    
    
    
    // какой индекс у ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let meal = sectionsOfMeals[indexPath.section][indexPath.row]
        
        //присваиваем каждой ячейки свои значениz
        cell.nameCell.text = meal.name
        cell.priceCell.text = String(meal.price)
        cell.descriptionCell.text = meal.desc
        cell.imageInCell.image = UIImage(named: meal.imageName!) ?? UIImage(named: "defaultImage")
        cell.isAdded = meal.isAdded
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
        
        let meal = mealsCoreData[indexPath.row]
        
        //Передаем объект meals на следующий экран
        nextVC.selectedMeal = meal
//            Meal(name: meal["name"], price: Int(meal["price"]), description: meal["description"], image: meal["id"], isAdded: nil)
        
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
}
