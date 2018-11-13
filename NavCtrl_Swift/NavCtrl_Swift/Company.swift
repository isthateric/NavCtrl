//
//  CompanyProducts.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 10/31/18.
//  Copyright © 2018 turntotech. All rights reserved.
//  master

import Foundation


class Company {

    var name: String
    var logo: String
    var url: String
    var products: [Product]
    
    init(name: String, logo: String, url: String, productsFrom: [Product]){
        self.name = name
        self.logo = logo
        self.url = url
        self.products = productsFrom
    }
    
}
