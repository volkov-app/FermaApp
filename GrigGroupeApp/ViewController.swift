//
//  ViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/31/20.
//

import UIKit

class ViewController: UIViewController {
    
    //имеется массив категорий
    var categories: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

//Стандартно создаём таблицу1
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    //Стандартно создаём таблицу2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        
        let model = categories[indexPath.row]
        cell.categoryNameLabel.text = model.name
        cell.categorySortOrderLabel.text = "\(model.sortOrder)"
        return cell
    }
}
