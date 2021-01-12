//
//  TableViewCell.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    //Чтобы тень использовать
    @IBOutlet weak var viewCell: UIView!
    
    //Для наполнения позиции меню
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var priceCell: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    var isAdded: Bool!
    var selectedMeal: Meal?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingUI()
    }
    
    func settingUI() {
        viewCell.dropShadow() //активируем тень
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
   
