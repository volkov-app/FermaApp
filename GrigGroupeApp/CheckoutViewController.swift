//
//  CheckoutViewController.swift
//  GrigGroupeApp
//
//  Created by Alex Rudoi on 2/2/21.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var addresTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var database: Firestore!
    
    var meals: [Meal] = []
    var globalPrice = 0
    var count = 0
    var isSuccededInfo: Bool!
    var isSuccededMeals: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        database = Firestore.firestore()
        
        activityIndicator.isHidden = true
        infoLabel.text = "Итого: \(globalPrice)"
    }
    
    @IBAction func sendOrderTapped(_ sender: UIButton) {
        
        guard let phoneNum = phoneNumberTF.text else {return}
        guard let addres = addresTF.text else {return}
        
        var order: [[String: Any]] = []
        
        for meal in meals {
            
            count += Int(meal.count)
            
            let mealParams: [String: Any] = [
                "name": meal.name!,
                "count": meal.count
            ]
            order.append(mealParams)
        }
        
        let infoParams: [String: Any] = [
            "addres": addres,
            "value": globalPrice,
            "count": count
        ]
        
        database.collection("orders").document("\(phoneNum)").setData(infoParams) { err  in
                    
            if let err = err {
                print("Error writing document: \(err)")
                self.isSuccededInfo = false
                self.activityIndicator.stopAnimating()
            } else {
                print("Document Info successfully written!")
                self.isSuccededInfo = true
            }
        }
        
        var i = 0
        for meal in meals {
            database.collection("orders").document("\(phoneNum)").collection("meals").document("\(meal.name!)").setData(order[i]) { err  in
                if let err = err {
                    print("Error writing document: \(err)")
                    self.isSuccededMeals = false
                    self.activityIndicator.stopAnimating()
                } else {
                    print("Document Meal \(meal.name!) successfully written!")
                    self.isSuccededMeals = true
                    
                    if meal.name! == order.last!["name"] as! String {
                        if self.isSuccededInfo && self.isSuccededMeals {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessView")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                
            }
            i += 1
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            
           
            
        }
        
        
    }
    
}
