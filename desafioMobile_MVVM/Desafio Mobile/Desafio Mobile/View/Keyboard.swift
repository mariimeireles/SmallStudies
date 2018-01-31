//
//  Keyboard.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 30/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
