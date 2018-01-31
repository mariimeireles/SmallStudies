//
//  CartViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 28/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var cartProducts = [ProductViewModel]()
    var sum = 0

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TotalLabelDidChange(label: totalLabel, sum: sum)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell") as? CartProductCell else { return UITableViewCell() }
        
        if let titleText = cartProducts[indexPath.row].title {
            cell.nameLabel.text = titleText
        } else {
            cell.nameLabel.text = "-"
        }
        
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        if let priceText = cartProducts[indexPath.row].price {
            cell.priceLabel.text = priceTextDidChange(priceText)
        } else {
            cell.priceLabel.text = "-"
        }
 
        if let sellerText = cartProducts[indexPath.row].seller{
            cell.sellerLabel.text = "vendedor: " + sellerText
        } else {
            cell.sellerLabel.text = "-"
        }
        
        if let imageURL = URL(string: cartProducts[indexPath.row].thumbnailHd!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                }
            }
        } else {
            cell.productImageView.image = UIImage(named: "notFound")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    @objc func buttonClick(_ button: UIButton) {
        let products = self.cartProducts[button.tag]
        sum -= products.price!
        TotalLabelDidChange(label: totalLabel, sum: sum)
        cartProducts.remove(at: button.tag)
 
        self.tableView.reloadData()
    }

    @IBAction func checkoutButton(_ sender: Any) {
        if cartProducts.count == 0{
            let alert = UIAlertController(title: "Ops!", message: "Adicione itens no carrinho para finalizar a compra", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCheckout"{
            let checkoutVC = segue.destination as! CheckoutViewController
            checkoutVC.sum = sum
        }
    }
    
}
