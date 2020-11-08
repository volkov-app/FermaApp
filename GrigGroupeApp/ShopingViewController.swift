//
//  ShopingViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit

class ShopingViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    var isMenuOpened = false
    
    @IBAction func changeState(_ sender: UIButton) {
        
        isMenuOpened = !isMenuOpened
        UIView.animate(withDuration: 1.3) {
            self.menuView.frame.size.height = self.isMenuOpened ? 150 : 50
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
