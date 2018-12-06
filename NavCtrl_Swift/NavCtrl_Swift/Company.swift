//
//  CompanyProducts.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 10/31/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation

class Company : NSObject{

    var name: String
    var logo: String
    var ticker: String
    var price: Double
    var products: [Product]
    
    init(name: String, ticker: String, logo: String, price: Double, productsFrom: [Product]){
        self.name = name
        self.logo = logo
        self.ticker = ticker
        self.price = price
        products = productsFrom
    }
    
    
}
