//
//  ProductCell.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var cartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
