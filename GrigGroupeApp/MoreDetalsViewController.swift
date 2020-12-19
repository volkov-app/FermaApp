//
//  MoreDetalsViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/30/20.
//

import UIKit

class MoreDetalsViewController: UIViewController {
    
    
    // Переносим все визуальные объекты
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var fotoImage: UIImageView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    var selectedMeal: Meal!
    
    // Чтобы получить параметры нужно определить их
    var name: String?
    var descript: String?
    var price: String?
    var image: UIImage?
    var isAded: Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Чтобы получить параметры после загрузки
        nameLable.text = selectedMeal.name
        descriptionLable.text = selectedMeal.desc
        priceLable.text = String(selectedMeal.price)
        fotoImage.image = UIImage(named: selectedMeal.imageName!) ?? UIImage(named: "defaultImage")
        
    }
    
    func setUI() {
        nameLable.sizeToFit()
        descriptionLable.sizeToFit()
        
        if selectedMeal.isAdded {
            addButtonOutlet.setTitle("Убрать из избранного", for: .normal)
            addButtonOutlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            addButtonOutlet.setTitle("Добавить в избранное", for: .normal)
            addButtonOutlet.backgroundColor = #colorLiteral(red: 0.5803921569, green: 0.3215686275, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if selectedMeal.isAdded {
            selectedMeal.isAdded = false
        } else {
            selectedMeal.isAdded = true
        }
        
        DatabaseManager.instance.updateMeal()
        setUI()
    }
    
}
