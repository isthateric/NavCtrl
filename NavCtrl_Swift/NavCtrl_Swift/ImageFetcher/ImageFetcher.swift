//
//  ImageFetcher.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 12/20/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit



struct Image: Decodable {
    let name: String
}


class ImageFetcher {
    
    
    var delegate: ImageFetcherDelegate?
    
    //calling delegate methods during the fetching process so that the delegate can respond accordingly
    func fetchCompanyImageFor(domain: String, imageView: UIImageView?) {

        guard let urlGet = URL(string: "https://logo.clearbit.com/\(domain)") else {return}
        
        let session = URLSession.shared
        let task =
            session.dataTask(with: urlGet) { (data: Data?, response: URLResponse?, error: Error?) in
                
            guard let imageData = data else {return}
                
                 DispatchQueue.main.async {
                     imageView?.image = UIImage(data: imageData)
                 }
                    
 
        }
        task.resume()
        
    }
}


