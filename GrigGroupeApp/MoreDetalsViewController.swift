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
    
    
    // Чтобы получить параметры нужно определить их
    var name: String?
    var descript: String?
    var price: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Чтобы получить параметры после загрузки
        nameLable.text = name!
        descriptionLable.text = descript!
        priceLable.text = price!
        fotoImage.image = image!
    }
    

}
