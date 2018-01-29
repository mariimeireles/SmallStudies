//
//  CartProductCell.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 28/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

class CartProductCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
