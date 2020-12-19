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
    
    @IBOutlet weak var tv: UITableView!
    
    var sectionsOfMeals: [[Meal]] = []
    var mealsCoreData: [Meal] = []
    
    var meals: [[String: String]] = []
    
    var category: Category!
    var categoryIndex: Int?
    
    
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
                
//                self.mealsCoreData = splitMeals(allMeal)
                self.mealsCoreData = allMeal
                self.sectionsOfMeals = splitMealsToSections(self.mealsCoreData)
            }
        }
        tv.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.name
        fecthData()
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
    
    @IBAction func filtersTapped(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersViewController
        
        vc.splitedMeals = sectionsOfMeals
        
        navigationController?.show(vc, sender: nil)
    }
}

//Показываем колличество клеток
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionsOfMeals[categoryIndex!].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        switch section {
//        case 0:
//            return "Pizza"
//        case 1:
//            return "СЫРЫ & МЯСО"
//        case 2:
//            return "ЗАКУСКИ"
//        case 3:
//            return "САЛАТЫ"
//        case 4:
//            return "ЯГОДЫ & ФРУКТЫ"
//        case 5:
//            return "БРУСКЕТТЫ НА НАШЕЙ ЧИАБАТТЕ"
//        case 6:
//            return "ГАРНИРЫ & ОВОЩИ"
//        case 7:
//            return "ДЕСЕРТЫ"
//        case 8:
//            return "АКВАРИУМ"
//        case 9:
//            return "СУПЫ"
//        case 10:
//            return "МЯСО"
//        case 11:
//            return "РЫБА"
//        case 12:
//            return "МОРЕПРОДУКТЫ"
//        case 13:
//            return "ВЫПЕЧКА"
//        case 14:
//            return "ДЕСЕРТ"
//        default:
//            return "Other"
//        }
//    }
    
    
    
    
    // какой индекс у ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let meal = sectionsOfMeals[categoryIndex!][indexPath.row]
        
        //присваиваем каждой ячейки свои значение
        cell.nameCell.text = meal.name
        cell.priceCell.text = String(meal.price)
        cell.descriptionCell.text = meal.desc
        cell.imageInCell.image = UIImage(named: meal.imageName!) ?? UIImage(named: "defaultImage")
        cell.isAdded = meal.isAdded

        if meal.isAdded {
            cell.heartImage?.image = UIImage(systemName: "heart.fill")
        } else {
            cell.heartImage?.image = UIImage(systemName: "heart")
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(heartTapped(_:)))
        cell.heartImage?.addGestureRecognizer(tap)
        
        return cell
    }
    
    @objc func heartTapped(_ sender: Meal)
    {
        if sender.isAdded {
            sender.isAdded = false
        } else {
            sender.isAdded = true
        }
        DatabaseManager.instance.updateMeal()
        
        fecthData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
        
        let meal = sectionsOfMeals[categoryIndex!][indexPath.row]
        
        //Передаем объект meals на следующий экран
        nextVC.selectedMeal = meal
        //            Meal(name: meal["name"], price: Int(meal["price"]), description: meal["description"], image: meal["id"], isAdded: nil)
        
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
}

