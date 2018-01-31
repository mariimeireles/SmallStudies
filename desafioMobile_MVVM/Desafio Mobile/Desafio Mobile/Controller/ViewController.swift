//
//  ViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
//class ViewController: UIViewController {

    var sum = 0
    var cartProducts = [ProductViewModel]()
    @IBOutlet weak var tableView: UITableView!
    private var networkProcessor: NetworkProcessor!
    private var productListViewModel: ProductListViewModel!
    private var dataSource: TableViewDataSource<ProductCell,ProductViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let errorAlert = UIAlertController(title: "Ops!", message: "Não foi possivel carregar os produtos", preferredStyle: UIAlertControllerStyle.alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.networkProcessor = NetworkProcessor()
        self.productListViewModel = ProductListViewModel(networkProcessor: self.networkProcessor, onSucess: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, onFailure: {
            self.present(errorAlert, animated: true, completion: nil)
        })
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let errorAlert = UIAlertController(title: "Ops!", message: "Não foi possivel carregar os produtos", preferredStyle: UIAlertControllerStyle.alert)
//        errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//
//        self.networkProcessor = NetworkProcessor()
//        self.productListViewModel = ProductListViewModel(networkProcessor: self.networkProcessor, onSucess: {
//
//            self.dataSource = TableViewDataSource(cellIdentifier: "ProductCell", items: self.productListViewModel.productsViewModel) { cell, viewModel in
//                cell.nameLabel.text = viewModel.title
//                cell.priceLabel.text = priceTextDidChange(viewModel.price)
//                cell.sellerLabel.text = "vendedor: " + viewModel.seller
//
////                if let imageURL = URL(string: viewModel.thumbnailHd!){
////                    DispatchQueue.global().async {
////                        let data = try? Data(contentsOf: imageURL)
////                        if let data = data{
////                            let image = UIImage(data: data)
////                            DispatchQueue.main.async {
////                                cell.productImageView.image = image
////                            }
////                        }
////                    }
////                }
//            }
//            self.tableView.dataSource = self.dataSource
//            self.tableView.reloadData()
//        }, onFailure: {
//            self.present(errorAlert, animated: true, completion: nil)
//        })
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.productListViewModel.productsViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell() }
        let product = self.productListViewModel.productAt(index: indexPath.row)
        if let titleText = product.title{
            cell.nameLabel.text = titleText
        }else{
            cell.nameLabel.text = "-"
        }

        cell.cartButton.tag = indexPath.row
        cell.cartButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)

        if let priceText = product.price{
            cell.priceLabel.text = priceTextDidChange(priceText)
        }else{
            cell.priceLabel.text = "-"
        }

        if let sellerText = product.seller{
            cell.sellerLabel.text = "vendedor: " + sellerText
        }else{
            cell.sellerLabel.text = "-"
        }

        if let imageURL = URL(string: product.thumbnailHd!){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                }
            }
        }else{
            cell.productImageView.image = UIImage(named: "notFound")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    @objc func buttonClick(_ button: UIButton){
        let cartProduct = self.productListViewModel.productsViewModel[button.tag]
        sum += cartProduct.price!
        cartProducts.append(cartProduct)
        let addToCartAlert = UIAlertController(title: "Item adicionado ao carrinho!", message: "", preferredStyle: UIAlertControllerStyle.alert)
        addToCartAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        addToCartAlert.addAction(UIAlertAction(title: "Ver Carrinho", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!)-> Void in
            self.performSegue(withIdentifier: "goToCart", sender: self)
        }))
        self.present(addToCartAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            let cartVC = segue.destination as! CartViewController
            let cartArray = self.cartProducts
            cartVC.cartProducts = cartArray
            cartVC.sum = sum
        }
    }
    
    @IBAction func unwindFromCart(unwindSegue: UIStoryboardSegue){
        let cartVC = unwindSegue.source as! CartViewController
        self.cartProducts = cartVC.cartProducts
        sum = cartVC.sum
    }
    
    @IBAction func unwindFromCheckout(unwindSegue: UIStoryboardSegue){
        self.sum = 0
        self.cartProducts = [ProductViewModel]()
    }
    
}
