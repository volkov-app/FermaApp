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
    //Задаём наши названия
//    var meals: [MealObject] = [MealObject(name: "Eggs",
//                                          price: 125,
//                                          description: "blablabla",
//                                          image: UIImage(named: "GrigGroupe")!,
//                                          isAdded: nil),
//                               MealObject(name: "Eggs2",
//                                          price: 2125,
//                                          description: "1blablabla",
//                                          image: UIImage(named: "Mask Group-1")!,
//                                          isAdded: nil)
//    ]
    var meals: [Meal] = []
    
    
    func splitMeals(_ meals: [Meal]) -> [Meal] {
        var result: [Meal] = []
        
        let unaddedMeal = meals.filter {
            $0.isAdded == false
        }
        
        result.append(contentsOf: unaddedMeal)
        
        return result
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fecthData()
    }
    
    func fecthData() {
        DatabaseManager.instance.fetchData { (done, meals) in
            if done, let allMeal = meals {
                self.meals = splitMeals(allMeal)
            }
        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseManager.instance.saveMeal(object: MealObject(name: "Eggs",
                                                              price: 125,
                                                              description: "blablabla",
                                                              image: "GrigGroupe",
                                                              isAdded: nil)) { (done) in
            if done {
                print("All is okay")
                fecthData()
            } else {
                print("something wrong")
            }
        }
        }
   
    }

//Показываем колличество клеток
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
        }
    
// какой индекс у ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
//присваиваем каждой ячейки свои значения
        cell.nameCell.text = meals[indexPath.row].name
        cell.priceCell.text = String(meals[indexPath.row].price)
        cell.descriptionCell.text = meals[indexPath.row].desc
        cell.imageInCell.image = UIImage(named: meals[indexPath.row].imageName!)
        
        return cell
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
//        nextVC.name = meals[indexPath.row].name
//        nextVC.price = String(meals[indexPath.row].price)
//        nextVC.descript = meals[indexPath.row].descriptionOfMeal
//        nextVC.image = meals[indexPath.row].image
        
        //Передаем объект meals на следующий экран
        nextVC.selectedMeal = meals[indexPath.row]
        
        
        navigationController?.pushViewController(nextVC, animated: true)
    
    
    }
}

