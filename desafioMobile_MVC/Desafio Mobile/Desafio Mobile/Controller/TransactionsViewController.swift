//
//  TransactionsViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 02/11/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit
import CoreData

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var transactions = [Transactions]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
        
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        do{
            let transactions = try PersistenceService.context.fetch(fetchRequest)
            self.transactions = transactions
            self.tableView.reloadData()
        } catch {
            fatalError("Failed to fetch transactions: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsCell") as? TransactionsCell else { return UITableViewCell() }
        
        cell.nameLabel.text = transactions[indexPath.row].name
        cell.valueLabel.text = transactions[indexPath.row].value
        cell.cardNumberLabel.text = "Cartão: \(String(describing: transactions[indexPath.row].cardNumber!))" 
        cell.DateLabel.text = transactions[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
