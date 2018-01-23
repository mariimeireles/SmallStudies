//
//  Post.swift
//  JSONDecoder
//
//  Created by Mariana Meireles | Stone on 1/22/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
