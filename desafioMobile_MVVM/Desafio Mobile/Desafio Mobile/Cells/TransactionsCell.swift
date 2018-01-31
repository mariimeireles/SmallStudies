//
//  TransactionsCell.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 02/11/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

class TransactionsCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
