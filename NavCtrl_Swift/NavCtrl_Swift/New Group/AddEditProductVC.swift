//
//  AddEditProductVC.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 11/19/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit

class AddEditProductVC : UIViewController{
            var productAssigned: Product?
            var productIndex: Int!
    
    @IBOutlet weak var productText: UITextField!
    @IBOutlet weak var productLogo: UITextField!
    @IBOutlet weak var productURL: UITextField!
    
    let defaults = UserDefaults.standard
    var companyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSaveMode))
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Product"
//        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector())
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if productAssigned == nil{
            productText.text! = "ADD COMPANY HERE"
            productLogo.text! = "ADD LOGO HERE"
            productURL.text! = "ADD URL HERE"
            self.title = "Add Product"
        } else{
        let logo = productAssigned?.logo
        let name = productAssigned?.name
        let url = productAssigned?.url
        productText.text! = name!
        productLogo.text! = logo!
        productURL.text! = url!
            self.title = " Edit Product"
            }
    }
    
        func toggleSaveMode() {
//                 guard let companyName = companyName else { return }
//
//                    Dao.sharedInstance.addNewProduct(to: companyName, productName: productText.text!, ProductLogo: productLogo.text!, ProductURL: productURL.text!)
            Dao.sharedInstance.updateProduct(Product: productAssigned!, newName: productText.text!, newLogo: productLogo.text!, newURL: productURL.text!)
                self.navigationController?.popViewController(animated: true)
    }

    
    func toggleAddMode(){

    }
}
