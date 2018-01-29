//
//  Post.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 31/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation

struct Post: Codable{
    let card_number: String
    let value: Int
    let cvv: Int
    let card_holder_name: String
    let exp_date: String
}
