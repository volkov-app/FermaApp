//
//  MenuViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit





class MenuViewController: UIViewController {
    
    @IBOutlet weak var viewCell: UIView!
    
    //Задаём наши названия
    var names = ["Яичница","Пельмени","Суп","Паста Карбонара"]
    var prices = ["100P","199P","300P","450"]
    var descriptions = ["Глазунья пожаренная без масла","Говядина и свинина","Капуста, свекла, курица, картошка","Спагетти из твёрдых сортов пшеници и бекон"]
    var images: [UIImage] = [#imageLiteral(resourceName: "food"),#imageLiteral(resourceName: "food2"),#imageLiteral(resourceName: "food"),#imageLiteral(resourceName: "food2")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }
   
    }

//Показываем колличество клеток
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        }
    
// какой индекс у ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
//присваиваем каждой ячейки свои значения
        cell.nameCell.text = names[indexPath.row]
        cell.priceCell.text = prices[indexPath.row]
        cell.descriptionCell.text = descriptions[indexPath.row]
        cell.imageInCell.image = images[indexPath.row]
        
        return cell
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "MoreDetalsViewController") as! MoreDetalsViewController
        nextVC.name = names[indexPath.row]
        nextVC.price = prices[indexPath.row]
        nextVC.descript = descriptions[indexPath.row]
        nextVC.image = images[indexPath.row]
        
        
        navigationController?.pushViewController(nextVC, animated: true)
    
    
    }
}

