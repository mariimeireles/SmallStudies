//
//  NetworkProcessor.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation

class NetworkProcessor {
    
    func downloadJSONFromURL(onSucess: @escaping([Product]) -> Void, onFailure: @escaping(Error) -> Void, httpFailure: @escaping(Int) -> Void) {
        
        let productsURL = URL(string: "https://raw.githubusercontent.com/stone-pagamentos/desafio-mobile/master/store/products.json")!
        
        URLSession.shared.dataTask(with: productsURL) { (data, response, error) in
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        guard let data = data else { return }
                        do {
                            let products = try JSONDecoder().decode([Product].self, from: data)
                            onSucess(products)
                        } catch let error {
                            print("Error serializing json:", error)
                            onFailure(error)
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                        httpFailure(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
                onFailure(error!)
            }
            }.resume()
    }
    
    func sendPost(postObject: [Post], onSucess: @escaping([Post]) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let postURL = URL(string: "https://private-cc690-starwarsstore1.apiary-mock.com/questions")!
        var request = URLRequest(url: postURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonBody = try JSONEncoder().encode(postObject)
            request.httpBody = jsonBody
        } catch {}
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil, let response = response {
                guard let data = data else { return }
                do {
                    let sentPost = try JSONDecoder().decode([Post].self, from: data)
                    onSucess(sentPost)
                    print(response)
                    print(sentPost)
                } catch {
                    print("Error serializing json:", error)
                    onFailure(error)
                }
            }
        }
        task.resume()
    }
    
}
