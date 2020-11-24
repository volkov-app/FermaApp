//
//  FavoritesTableViewController.swift
//  GrigGroupeApp
//
//  Created by Alex Rudoi on 24/11/20.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        DatabaseManager.instance.fetchData { (done, meals) in
            if done, let allMeal = meals {
                self.meals = splitMeals(allMeal)
            }
        }
        tableView.reloadData()
    }
    
    func splitMeals(_ meals: [Meal]) -> [Meal] {
       
        var result: [Meal] = []
        
        //Сюда будем записывать отфильтрованное блюдо
        let unaddedMeal = meals.filter {
            $0.isAdded == true // $0. проход по каждому элементу
        }
        
        result.append(contentsOf: unaddedMeal)
        
        return result
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let meal = meals[indexPath.row]
        
        //присваиваем каждой ячейки свои значениz
        cell.nameCell.text = meal.name
        cell.priceCell.text = String(meal.price)
        cell.descriptionCell.text = meal.desc
        cell.imageInCell.image = UIImage(named: meal.imageName!) ?? UIImage(named: "defaultImage")
        cell.isAdded = meal.isAdded
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
        
        let meal = meals[indexPath.row]
        
        //Передаем объект meals на следующий экран
        nextVC.selectedMeal = meal
        //            Meal(name: meal["name"], price: Int(meal["price"]), description: meal["description"], image: meal["id"], isAdded: nil)
        
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
}
