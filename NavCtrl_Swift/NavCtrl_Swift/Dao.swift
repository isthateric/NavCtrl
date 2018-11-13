//
//  Dao.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 11/5/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit

class Dao {
    
    static let sharedInstance = Dao()
    
    var companyArray = [Company]()
    
    init() {
        companyArray = create()
    }
    
    func create() -> [Company] {
        
        let appleCom = Company(name: "Apple", logo: "img-companyLogo_Apple", url: "url", productsFrom: [Product]())
        let twitterCom = Company(name: "Twitter", logo: "img-companyLogo_Twitter", url: "url", productsFrom: [Product]())
        let teslaCom = Company(name: "Tesla", logo: "img-companyLogo_Tesla", url: "url", productsFrom: [Product]())
        let googleCom = Company(name: "Google", logo: "img-companyLogo_Google", url: "url", productsFrom: [Product]())


        googleCom.products.append(Product(name: "Google Adwords", logo: "img-companyLogo_Google", url: "https://ads.google.com/"))
        googleCom.products.append(Product(name: "Pixel 3", logo: "img-companyLogo_Google", url: "https://store.google.com/product/pixel_3"))
        googleCom.products.append(Product(name: "Google Chrome", logo: "img-companyLogo_Google", url: "https://www.google.com/chrome/"))
        
        appleCom.products.append(Product(name: "Mac", logo: "img-companyLogo_Apple", url: "https://www.apple.com/mac/"))
        appleCom.products.append(Product(name: "iPod", logo: "img-companyLogo_Apple", url: "https://www.apple.com/ipod-touch/"))
        appleCom.products.append(Product(name: "iPhone", logo: "img-companyLogo_Apple", url: "https://www.apple.com/iphone/"))
        
        twitterCom.products.append(Product(name: "App", logo: "img-companyLogo_Twitter", url: "https://itunes.apple.com/us/app/twitter/id333903271?mt=8"))
        twitterCom.products.append(Product(name: "Website", logo: "img-companyLogo_Twitter", url: "https://twitter.com/Twitter"))
        twitterCom.products.append(Product(name: "merchandise", logo: "img-companyLogo_Twitter", url: "https://twitter.com/Twitter"))
        
        teslaCom.products.append(Product(name: "Model S", logo: "img-companyLogo_Tesla", url: "https://www.tesla.com/models"))
        teslaCom.products.append(Product(name: "Model 3", logo: "img-companyLogo_Tesla", url: "https://www.tesla.com/model3"))
        teslaCom.products.append(Product(name: "Model X", logo: "img-companyLogo_Tesla", url: "https://www.tesla.com/modelx"))

        let companys = [appleCom, twitterCom, teslaCom, googleCom]
        return companys
    }
       
//    }
    
    /*
     class func getProduct() -> [companyProducts]
     {
     return [self.appleProducts(), self.twitterProducts(), self.teslaProducts(), self.googleProducts()]
     }
     
     private class func appleProducts() -> companyProducts{
     var Products = [product]()
     
     Products.append(product(name: "Mac", logo: "img-companyLogo_Apple", url: ""))
     Products.append(product(name: "iPod", logo: "img-companyLogo_Apple", url: ""))
     Products.append(product(name: "iPhone", logo: "img-companyLogo_Apple", url: ""))
     
     return companyProducts(name: "Apple", logo: "img-companyLogo_Apple", url: "", productsFrom: Products)
     }
     private class func twitterProducts() -> companyProducts{
     var Products = [product]()
     
     Products.append(product(name: "App", logo: "img-companyLogo_Twitter", url: ""))
     Products.append(product(name: "Website", logo: "img-companyLogo_Twitter", url: ""))
     Products.append(product(name: "merchandise", logo: "img-companyLogo_Twitter", url: ""))
     
     return companyProducts(name: "Twitter Products", logo: "img-companyLogo_Twitter", url: "", productsFrom: Products)
     }
     private class func teslaProducts() -> companyProducts{
     var Products = [product]()
     
     Products.append(product(name: "Model S", logo: "img-companyLogo_Tesla", url: ""))
     Products.append(product(name: "Model 3", logo: "img-companyLogo_Tesla", url: ""))
     Products.append(product(name: "Model X", logo: "img-companyLogo_Tesla", url: ""))
     
     return companyProducts(name: "Tesla Products", logo: "img-companyLogo_Tesla", url: "", productsFrom: Products)
     }
     private class func googleProducts() -> companyProducts{
     var Products = [product]()
     
     Products.append(product(name: "Google Adwords", logo: "img-companyLogo_Google", url: ""))
     Products.append(product(name: "Pixel 3", logo: "img-companyLogo_Google", url: ""))
     Products.append(product(name: "Google Chrome", logo: "img-companyLogo_Google", url: ""))
     
     return companyProducts(name: "Google Products", logo: "img-companyLogo_Google", url: "", productsFrom: Products)
     }
     //var adwords = Product(name: "Google Adwords", logo: "img-companyLogo_Google", url: "")
     //var phone = Product(name: "Pixel 3", logo: "img-companyLogo_Google", url: "")
     //var chrome = Product(name: "Google Chrome", logo: "img-companyLogo_Google", url: "")
 */
}
