//
//  CheckoutViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 30/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardExpirationTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    var buyerInfos = [Post]()
    var transactions = [Transactions]()
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TotalLabelDidChange(label: totalLabel, sum: sum)
        self.hideKeyboard()
        cardNumberTextField.keyboardType = .numberPad
        cardExpirationTextField.keyboardType = .numberPad
        cvvTextField.keyboardType = .numberPad
    }
    
    @IBAction func payButton(_ sender: Any) {
        if checkFields() {
            payButton.isEnabled = false
            addInfosAtPostArray()
            sendPost()
            saveData()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == cardExpirationTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 30), animated: true)
        }
        if textField == cvvTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == cardNumberTextField{
            var stringText = cardNumberTextField.text
            if stringText == nil{
                stringText = ""
            }

            if (stringText!.count == 4 || stringText!.count == 9 || stringText!.count == 14) && string != "" {
                cardNumberTextField.text = "\(cardNumberTextField.text!) \(string)"
                return false
            }
            if range.length + range.location > (cardNumberTextField.text?.count)! {
                return false
            }
            let newLenght = (cardNumberTextField.text?.count)! + string.count - range.length
            return newLenght <= 19
        }
        if textField == cardExpirationTextField {
            var stringText = cardExpirationTextField.text
            if stringText == nil{
                stringText = ""
            }
            if stringText!.count == 2 && string != "" {
                cardExpirationTextField.text = "\(cardExpirationTextField.text!)/\(string)"
                return false
            }
            if range.length + range.location > (cardExpirationTextField.text?.count)! {
                return false
            }
            let newLenght = (cardExpirationTextField.text?.count)! + string.count - range.length
            return newLenght <= 5
        }
        return true
    }
    
    func checkFields() -> Bool {
        if (cardHolderNameTextField.text!.isEmpty || cardNumberTextField.text!.isEmpty || cardExpirationTextField.text!.isEmpty || cvvTextField.text!.isEmpty) {
            
            let emptySpaceAlert = UIAlertController(title: "Atenção", message: "Há campos não preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            emptySpaceAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(emptySpaceAlert, animated: true, completion: nil)
            return false
        }
        
        if cardExpirationTextField.text!.count > 0 && cardExpirationTextField.text!.count < 5 {
            
            let cardExpirationAlert = UIAlertController(title: "Atenção", message: "O vencimento do cartão deve estar no formato mm/aa", preferredStyle: UIAlertControllerStyle.alert)
            cardExpirationAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(cardExpirationAlert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func addInfosAtPostArray() {
        
        var cardNumber = ""
        let texts = cardNumberTextField.text?.components(separatedBy: [" "]).flatMap{ String($0.trimmingCharacters(in: .whitespaces))}
        for item in texts! {
            cardNumber += String(item)
        }
        let value = sum
        let cvv = Int(cvvTextField.text!)!
        let cardHolderName = cardHolderNameTextField.text!
        let expDate = cardExpirationTextField.text!
        let newPost = Post(card_number: cardNumber, value: value, cvv: cvv, card_holder_name: cardHolderName, exp_date: expDate)
        buyerInfos.append(newPost)
    }
    
    func sendPost() {
        let networkProcessor = NetworkProcessor()
        networkProcessor.sendPost(postObject: buyerInfos,
                                  onSucess: {_ in
                                    let purchaseAlert = UIAlertController(title: "Yay!", message: "Sua compra foi efetuada com sucesso", preferredStyle: UIAlertControllerStyle.alert)
                                    purchaseAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
                                        self.payButton.isEnabled = true
                                        self.performSegue(withIdentifier: "unwindToMain", sender: self)
                                    }))
                                    self.present(purchaseAlert, animated: true, completion: nil)
        }, onFailure: {_ in
            let purchaseAlert = UIAlertController(title: "Vixi!", message: "Houve algum erro na compra, tente novamente", preferredStyle: UIAlertControllerStyle.alert)
            purchaseAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(purchaseAlert, animated: true, completion: nil)
        })
    }
    
    func saveData() {
        
        let name = cardHolderNameTextField.text!
        var cardNumber = ""
        let texts = cardNumberTextField.text?.components(separatedBy: [" "]).flatMap{ String($0.trimmingCharacters(in: .whitespaces))}
        for item in texts! {
            cardNumber += String(item)
        }
        let lastFourDigits = String(cardNumber.suffix(4))
        let value = totalLabel.text!
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let transition = Transactions(context: PersistenceService.context)
        transition.name = name
        transition.cardNumber = lastFourDigits
        transition.value = value
        transition.date = formatter.string(from: date)
        PersistenceService.saveContext()
        self.transactions.append(transition)
    }

}



