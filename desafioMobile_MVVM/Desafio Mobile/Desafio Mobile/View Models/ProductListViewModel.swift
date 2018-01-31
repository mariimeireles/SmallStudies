//
//  ProductListViewModel.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles | Stone on 1/29/18.
//  Copyright © 2018 Mariana Meireles. All rights reserved.
//

import Foundation

class ProductListViewModel {
    
    private var networkProcessor: NetworkProcessor
    private (set) var productsViewModel: [ProductViewModel] = [ProductViewModel]()
    private var onSucess: () -> () = { }
    private var onFailure: () -> () = { }
    
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
        }, onFailure: { _ in
            self.onFailure()
        }, httpFailure: { _ in
            self.onFailure()
        })
    }
    
    func productAt(index: Int) -> ProductViewModel {
        
        return self.productsViewModel[index]
    }
    
}

class ProductViewModel {
    
    let title: String!
    let price: Int!
    let zipcode: String!
    let seller: String!
    let thumbnailHd: String!
    
    init(product: Product) {
        self.title = product.title
        self.price = product.price
        self.zipcode = product.zipcode
        self.seller = product.seller
        self.thumbnailHd = product.thumbnailHd
    }
    
    init(title: String, price: Int, zipcode: String, seller: String, thumbnailHd: String) {
        self.title = title
        self.price = price
        self.zipcode = zipcode
        self.seller = seller
        self.thumbnailHd = thumbnailHd
    }
    
}
