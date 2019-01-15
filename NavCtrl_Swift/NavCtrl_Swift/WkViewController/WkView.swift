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
    let addEditProduct = AddEditProductVC.self
    let addEditView = AddEditProductVC()

    @IBOutlet weak var wkWeb: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        self.title = "Product Link"
    }
    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        wkWeb.load(urlRequest)
        
    }
    
    func toggleEditMode() {
       // CDC.sharedInstance.selectedCompany = nil
        self.addEditView.productAssigned = nil
        addEditView.isAdding = false
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(self.addEditView, animated: false)

            
    }
    
    
}

