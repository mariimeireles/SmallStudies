//
//  ViewController.swift
//  JSONDecoder
//
//  Created by Mariana Meireles | Stone on 1/22/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dataView: UITextView!
    
    @IBAction func getDataPressed(_ sender: Any) {
        let jsonUrlString = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
        let apiManager = APIManager(url: jsonUrlString!)
        apiManager.downloadJSONFromURL(onSucess: { (result) in
            print(result)
            DispatchQueue.main.async {
                self.dataView?.text = String(describing: result)
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

