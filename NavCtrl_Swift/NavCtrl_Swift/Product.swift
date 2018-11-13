//
//  Products.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 10/31/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation


class Product {
    
    var name: String
    var logo: String
    var url: String
    
    
   init(name: String, logo: String, url: String)
    {
        self.name = name
        self.logo = logo
        self.url = url
    }

}
