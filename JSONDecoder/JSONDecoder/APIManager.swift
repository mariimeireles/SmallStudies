//
//  APIManager.swift
//  JSONDecoder
//
//  Created by Mariana Meireles | Stone on 1/22/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class APIManager{
    
    let url: URL
    
    init(url: URL){
        self.url = url
    }
    
    func downloadJSONFromURL(onSucess: @escaping(Post) -> Void, onFailure: @escaping(Error) -> Void){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        guard let data = data else { return }
                        do {
                            let post = try JSONDecoder().decode(Post.self, from: data)
                            onSucess(post)
                        } catch let error {
                            print("Error serializing json:", error)
                            onFailure(error)
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            }.resume()
    }
    
}
