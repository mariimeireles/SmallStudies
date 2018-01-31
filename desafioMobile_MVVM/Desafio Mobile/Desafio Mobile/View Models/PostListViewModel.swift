//
//  PostListViewModel.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles | Stone on 1/31/18.
//  Copyright © 2018 Mariana Meireles. All rights reserved.
//

import Foundation

lass PostListViewModel {
    
    private var networkProcessor: NetworkProcessor
    private (set) var productsViewModel = [ProductViewModel]()
    private var onSucess: () -> () = {}
    private var onFailure: () -> () = {}
    
    init(networkProcessor: NetworkProcessor, onSucess: @escaping () -> (), onFailure: @escaping () -> ()) {
        self.networkProcessor = networkProcessor
        self.onSucess = onSucess
        self.onFailure = onFailure
        populateProducts()
    }
    
    private func populateProducts() {
        
        self.networkProcessor.downloadJSONFromURL(onSucess: { product in
            self.productsViewModel = product.map(ProductViewModel.init)
            self.onSucess()
        }, onFailure: { error in
            self.onFailure()
        }, httpFailure: { httpFailure in
            self.onFailure()
        })
    }
    
    func productAt(index: Int) -> ProductViewModel {
        
        return self.productsViewModel[index]
    }
    
}

class PostViewModel {
    
    let title: String!
    let price: Int!
    let zipcode: String!
    let seller: String!
    let thumbnailHd: String!
    
    init (product: Product) {
        self.title = product.title
        self.price = product.price
        self.zipcode = product.zipcode
        self.seller = product.seller
        self.thumbnailHd = product.thumbnailHd
    }
    
}
