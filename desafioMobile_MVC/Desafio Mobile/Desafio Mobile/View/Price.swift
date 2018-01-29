//
//  Label.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 29/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

func TotalLabelDidChange(label: UILabel, sum: Int) {
    var total = String(sum)
    if sum != 0{
        total.insert(",", at: total.index(total.endIndex, offsetBy: -2))
        if total.count >= 7{
            total.insert(".", at: total.index(total.endIndex, offsetBy: -6))
        }
    }
    label.text = "Total: R$ " + total
}

func priceTextDidChange(_ priceText: Int) -> String{
    var price = String(priceText)
    price.insert(",", at: price.index(price.endIndex, offsetBy: -2))
    if price.count >= 7{
        price.insert(".", at: price.index(price.endIndex, offsetBy: -6))
    }
    return "R$ " + price
}
