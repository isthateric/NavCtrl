//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import WebKit

class ProductVC: UIViewController {
    
    
    
    @IBOutlet var tableView: UITableView!
    var products: [Product]?
    var wkViewController: WkView?
    let web = WKWebView()
    let addEditproduct = AddEditProductVC()
//    var newProductListed: [Product]?
//    let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(toggleAddMode))
    override func viewDidLoad() {
        super.viewDidLoad()
       
           
            let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
            self.navigationItem.rightBarButtonItem = editBarButton
        
//        let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(toggleAddMode))
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let title = self.title {
            products = Dao.sharedInstance.getProductsFor(companyName: title)
            tableView.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleEditMode() {

            if self.navigationItem.rightBarButtonItem?.title == "Edit" {
                self.tableView.setEditing(true, animated: true)
                self.tableView.allowsSelectionDuringEditing = true
                self.navigationItem.rightBarButtonItem?.title = "Done"
            } else {
                self.tableView.setEditing(false, animated: true)
                self.tableView.allowsSelectionDuringEditing = false
                self.navigationItem.rightBarButtonItem?.title = "Edit"
            }
//        if self.navigationItem.rightBarButtonItem?.isEnabled == true {
//            let companyName =  self.title
//            addEditproduct.companyName = companyName
//            self.navigationController?.pushViewController(self.addEditproduct, animated: true)
//        }
        
    }
    
    func toggleAddMode(){
        self.addEditproduct.productAssigned = nil
        self.navigationController?.pushViewController(self.addEditproduct, animated: true)

//        if self.navigationItem.rightBarButtonItem?.title == "Add" {
//            self.tableView.setEditing(true, animated: true)
//            self.navigationController?.pushViewController(AddEditProductVC(), animated: true)
//            self.tableView.allowsSelectionDuringEditing = true
//
        //}
    }
    
}




extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // Return the number of rows in the section.
        if let productCount = self.products?.count {
            return productCount
        } else {
            print("unknown number of rows... \"products\" property is nil!")
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        if let product = products?[indexPath.row] {
            cell.imageView?.image = UIImage.init(named: product.logo)
            cell.textLabel?.text = product.name
        }
        return cell
    }
    
        

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        guard let currentProduct = products?[indexPath.row] else { return }
        
//        if self.navigationItem.rightBarButtonItem?.title == "done"{
//            let productEdit = products?[indexPath.row]{
//                navigationController?.pushViewController(self.addEdito, animated: true)
//            }
//        }
        if  self.tableView.isEditing == true {
            self.addEditproduct.productAssigned = currentProduct
            self.navigationController?.pushViewController(self.addEditproduct, animated: true)
            return
        }
        
        
        if let product = products?[indexPath.row] {
            self.wkViewController = WkView()
                       self.wkViewController?.urlString = product.url
                        self.navigationController?.pushViewController(self.wkViewController!, animated: true)
                        return
        }

        let row = indexPath.row
        print("Row: \(row)")
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == UITableViewCellEditingStyle.delete{
            products?.remove(at: indexPath.row)
            tableView.reloadData()
        }
        }
        
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      
        let item = products![sourceIndexPath.row]
        products?.remove(at: sourceIndexPath.row)
        products?.insert(item, at: destinationIndexPath.row)
    }
  
}

