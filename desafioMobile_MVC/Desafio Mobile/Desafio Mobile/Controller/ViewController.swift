//
//  ViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sum = 0
    var cartProducts = [Product]()
    private var products = [Product]()
    var transactions = [Transactions]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let errorAlert = UIAlertController(title: "Ops!", message: "Não foi possivel carregar os produtos", preferredStyle: UIAlertControllerStyle.alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let jsonUrlString = URL(string: "https://raw.githubusercontent.com/stone-pagamentos/desafio-mobile/master/store/products.json")
        let networkProcessor = NetworkProcessor(url: jsonUrlString!)
        networkProcessor.downloadJSONFromURL(onSucess: { (result) in
            self.products = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, onFailure: {_ in
            self.present(errorAlert, animated: true, completion: nil)
        }, httpFailure: {_ in
            self.present(errorAlert, animated: true, completion: nil)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell() }
        
        if let titleText = products[indexPath.row].title{
            cell.nameLabel.text = titleText
        }else{
            cell.nameLabel.text = "-"
        }
        
        cell.cartButton.tag = indexPath.row
        cell.cartButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        if let priceText = products[indexPath.row].price{
            cell.priceLabel.text = priceTextDidChange(priceText)
        }else{
            cell.priceLabel.text = "-"
        }
        
        if let sellerText = products[indexPath.row].seller{
            cell.sellerLabel.text = "vendedor: " + sellerText
        }else{
            cell.sellerLabel.text = "-"
        }
        
        if let imageURL = URL(string: products[indexPath.row].thumbnailHd!){
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
        let cartProduct = products[button.tag]
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
        cartProducts = cartVC.cartProducts
        sum = cartVC.sum
    }
    
    @IBAction func unwindFromChechout(unwindSegue: UIStoryboardSegue){
        self.sum = 0
        self.cartProducts = [Product]()
        
    }
    
}
