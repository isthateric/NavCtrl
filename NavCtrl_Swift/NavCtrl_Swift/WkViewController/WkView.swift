//
//  WkView.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 10/25/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WkView: UIViewController {
    
    var urlString = "https://www.google.com"
    
    @IBOutlet weak var wkWeb: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        wkWeb.load(urlRequest)
        
        
    }
}

