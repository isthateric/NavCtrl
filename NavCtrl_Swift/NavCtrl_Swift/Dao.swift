//
//  Dao.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 11/5/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation


import Foundation
import UIKit
class Dao {
 let defaults = UserDefaults.standard

    static let sharedInstance = Dao()
    
    var companyArray = [Company]()
//    var createdCompany = [Company]()
//    var productArray = [Product]()
    
    init() {
        companyArray = create()
//        productArray = [Product]()
        
        //createdCompany = newCompCreated()
    }
    
    func create() -> [Company] {
        
        let appleCom = Company(name: "Apple", logo: "img-companyLogo_Apple", url: "https://www.apple.com/", productsFrom: [Product]())
        let twitterCom = Company(name: "Twitter", logo: "img-companyLogo_Twitter", url: "https://twitter.com/", productsFrom: [Product]())
        let teslaCom = Company(name: "Tesla", logo: "img-companyLogo_Tesla", url: "https://www.tesla.com/", productsFrom: [Product]())
        let googleCom = Company(name: "Google", logo: "img-companyLogo_Google", url: "https://www.google.com/", productsFrom: [Product]())
        
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
//    func newCompCreated() -> [Company] {
//        let newComp = Company(name: (defaults.string(forKey: "NAME"))!, logo: (defaults.string(forKey: "INIT"))!, url: (defaults.string(forKey: "URL"))!, productsFrom:[Product]())
//        companyArray.append( newComp )
//      //  newComp.products.append(Product(name: "who", logo: "img-companyLogo_Apple", url: "https://www.apple.com/mac/"))
//        return [newComp]
//
//    }
    func newCompCreate(newName: String, newLogo: String, newURL: String) {
        let newComp = Company(name: newName, logo: newLogo, url: newURL, productsFrom:[Product]())
        companyArray.append( newComp )
//        return newComp
    }
    
    func editCell(){
    
    }
    
    func addNewProduct(to companiName: String, productName: String, ProductLogo: String, ProductURL: String) {
        for (index, company) in companyArray.enumerated() {
            if company.name == companiName {
                let newProduct = Product(name: productName, logo: ProductLogo, url: ProductURL)
                companyArray[index].products.append(newProduct)
            }
        }
//        productArray.append(newProduct)
//        return newProduct
    }
    
    func getProductsFor(companyName: String) -> [Product]? {
        for company in companyArray {
            if company.name == companyName {
                return company.products
            }
        }
        return nil
    }
    
    func updateCompany(index: Int, newName: String, newLogo: String, newURL: String){
        //companyArray[index]
        companyArray[index].name = newName
        companyArray[index].logo = newLogo
        companyArray[index].url = newURL
        return
    }
    
    func updateCompany(company: Company, newName: String, newLogo: String, newURL: String){
        //companyArray[index]
        company.name = newName
        company.logo = newLogo
        company.url = newURL
        return
    }
    
    func updateProduct(Product: Product, newName: String, newLogo: String, newURL: String){
        Product.name = newName
        Product.logo = newLogo
        Product.url = newURL
        
        return
}
}
