//
//  AboutViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/26/20.
//

import UIKit

class AboutViewController: UIViewController {

    //3 шара
    @IBOutlet weak var blueBall: UIView!
    @IBOutlet weak var greenBall: UIView!
    @IBOutlet weak var yellowBall: UIView!
    @IBOutlet weak var redBall: UIView!
    
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var Lable1: UILabel!
    @IBOutlet weak var mainTF: UITextField!
    @IBAction func textFieldColor(_ sender: UITextField) {
    }
    
    @IBAction func mainTextField1(_ sender: UITextField) {
        guard let mainNumber = mainTF.text
        else { return }
        
        numberLable.text = mainNumber
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true) }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func TF2(_ sender: Any) {
    }
    
    @IBAction func TextField(_ sender: UITextField) {
        
        
    }
    
}






