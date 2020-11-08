//
//  UIView extention.swift
//  GrigGroupeApp
//
//  Created by user183382 on 10/30/20.
//

import UIKit

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
