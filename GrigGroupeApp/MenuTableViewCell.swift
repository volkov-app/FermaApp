//
//  MenuTableViewCell.swift
//  GrigGroupeApp
//
//  Created by Alex Rudoi on 15/12/20.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cateforyLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        dropShadowCategoryCell(iconView)
    }
    
    func config(name: String, image: UIImage) {
        cateforyLabel.text = name
        iconImageView.image = image
    }
    
}
