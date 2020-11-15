//
//  MenuViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    
    @IBOutlet weak var viewCell: UIView!
    
     @IBOutlet weak var tableView: UITableView!
    
    var sectionsOfMeals: [[Meal]] = []
    var meals: [Meal] = []
    
    func splitMealsToSections(_ mealsArray: [Meal]) -> [[Meal]] {
        var result: [[Meal]] = []
        
        let soupMeals = mealsArray.filter {
            $0.price < 550
        }
        
        let otherMeals = mealsArray.filter {
            $0.price > 550
        }
        
        result.append(soupMeals)
        
        result.append(otherMeals)
        
        return result
    }
    
    func createNewMeals() {
        
        let mealsArray = getArray()
        mealsArray.forEach { (meal) in
            
            DatabaseManager.instance.saveMeal(object: MealObject(name: meal[1],
                                                                 price: Int(meal[3])!,
                                                                 description: meal[2],
                                                                 image: meal[0],
                                                                 isAdded: nil))
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
                self.meals = splitMeals(allMeal)
                self.sectionsOfMeals = splitMealsToSections(self.meals)
            }
        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fecthData()
        
//        meals.forEach { (meal) in
//            DatabaseManager.instance.deleteMeal(meal: meal)
//        }
//
//
//        createNewMeals()
//
//
//        fecthData()
    }
    
}

func getArray() -> [[String]] {
    
    //Массив из обьектов с их параметрами
    var dataArray : [[String]] = []
    
    //Массив из одиного обьекта с его параметрами
    var itemParametrsArray: [String] = []
    
    if let path = Bundle.main.path(forResource: "tableofmeals", ofType: "csv") {
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if var dataArr = dataEncoded?.components(separatedBy: "\r\n").map({ $0.components(separatedBy: ";") })
            {
                dataArr.remove(at: dataArr.count-1)
                dataArr.forEach { (line) in
                    
                    
                    itemParametrsArray = []
                    
                    let str = line.first?.split(separator: ",")
                    
                    
                    str?.forEach({ (some) in
                        let value = String(some)
                        
                        itemParametrsArray.append(value)
                    })
                    
                    dataArray.append(itemParametrsArray)
                }
                
            }
        }
        catch let jsonErr {
            print("\n Error read CSV file: \n ", jsonErr)
        }
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
        if section == 1 {
            return "Дорого"
        } else {
            return "Дешево"
        }
    }
    
    // какой индекс у ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let section = sectionsOfMeals[indexPath.section]
        
        //присваиваем каждой ячейки свои значения
        cell.nameCell.text = section[indexPath.row].name
        cell.priceCell.text = String(section[indexPath.row].price)
        cell.descriptionCell.text = section[indexPath.row].desc
        cell.imageInCell.image = UIImage(named: section[indexPath.row].imageName!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
        
        //Передаем объект meals на следующий экран
        nextVC.selectedMeal = sectionsOfMeals[indexPath.section][indexPath.row]
        
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
}

