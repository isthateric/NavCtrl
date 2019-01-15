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
    var productAssigned: ProductCore?
    var productIndex: Int!
    var currentProduct: Product?
    var isAdding = true
    
    @IBOutlet weak var productText: UITextField!
    @IBOutlet weak var productLogo: UITextField!
    @IBOutlet weak var productURL: UITextField!
    
    let defaults = UserDefaults.standard
    var companyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSaveMode))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isAdding {
            title = "Add Product"
                        productText.placeholder! = "ADD Product Name HERE"
                        productLogo.placeholder! = "ADD PRODUCT IMAGE URL HERE"
                        productURL.placeholder! = "ADD URL Example: https://www.apple.com/mac"
                        productAssigned = nil
        } else {
            title = "Edit Product"
            productText.text = CDC.sharedInstance.selectedProduct?.name
            productLogo.text = CDC.sharedInstance.selectedProduct?.logo
            productURL.text = CDC.sharedInstance.selectedProduct?.url
            productAssigned =  CDC.sharedInstance.selectedProduct
        }
        
        productText.text = CDC.sharedInstance.selectedProduct?.name
        productLogo.text = CDC.sharedInstance.selectedProduct?.logo
        productURL.text = CDC.sharedInstance.selectedProduct?.url
    }
        func toggleSaveMode() {
            print(productText)
            if productAssigned == nil {
                CDC.sharedInstance.addNewProduct(productName: productText.text!, productLogo: productLogo.text!, productURL: productURL.text!)
            } else{
                CDC.sharedInstance.updateProduct(newName: productText.text!, newLogo: productLogo.text!, newURL: productURL.text!)
            }
            self.navigationController?.popViewController(animated: true)
    }
}
