//
//  Product.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation

struct Product: Codable {
    
    let title: String?
    let price: Int?
    let zipcode: String?
    let seller: String?
    let thumbnailHd: String?
    
    init (productViewModel: ProductViewModel) {
        
        self.title = productViewModel.title
        self.price = productViewModel.price
        self.zipcode = productViewModel.zipcode
        self.seller = productViewModel.seller
        self.thumbnailHd = productViewModel.thumbnailHd
    }
}
