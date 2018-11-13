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
//    let applePro = ["Mac","iPod","iphone"]
//    let twitterPro = ["App","Website","Merch"]
//    let teslaPro = ["Model S","Model 3","Model X"]
//    let googlePro = ["adwords","phone","chrome"]
//    let logos = ["img-companyLogo_Apple","img-companyLogo_Twitter", "img-companyLogo_Tesla","img-companyLogo_Google"]
    
    var wkViewController: WkView?
    let web = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        if self.title == "Apple" {
//           self.products = applePro
//       }
//        if self.title == "Twitter" {
//            self.products = twitterPro
//        }
//        if self.title == "Tesla" {
//            self.products = teslaPro
//        }
//        if self.title == "Google" {
//            self.products = googlePro
//        }
//        self.tableView.reloadData()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleEditMode() {
        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Done"
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
        
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
        
//        if title == "Apple"{
//            cell.imageView?.image = UIImage.init(named: "img-companyLogo_Apple")
//            cell.textLabel?.text = applePro[indexPath.row]
//        }
//        if title == "Twitter"{
//            cell.imageView?.image = UIImage.init(named: "img-companyLogo_Twitter")
//            cell.textLabel?.text = twitterPro[indexPath.row]
//        }
//        if title == "Tesla"{
//            cell.imageView?.image = UIImage.init(named: "img-companyLogo_Tesla")
//            cell.textLabel?.text = teslaPro[indexPath.row]
//        }
//
//        if title == "Google"{
//            cell.imageView?.image = UIImage.init(named: "img-companyLogo_Google")
//            cell.textLabel?.text = googlePro[indexPath.row]
//
//        }
//        else{
//            cell.imageView?.image = UIImage.init(named: "")
//        }
        
//        cell.imageView?.image = UIImage.init(named: (logos[indexPath.row] + ".jpg"))
//        //configure the cell
//        cell.textLabel?.text = self.products?[indexPath.row]
        return cell
    }
    
        

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let product = products?[indexPath.row] {
            self.wkViewController = WkView()
                       self.wkViewController?.urlString = product.url
                        self.navigationController?.pushViewController(self.wkViewController!, animated: true)
                        return
        }
//        if self.title == "Apple" {
//            self.products = applePro
//            self.wkViewController = WkView()
//           self.wkViewController?.urlString = "https://apple.com"
//            self.navigationController?.pushViewController(self.wkViewController!, animated: true)
//            return
//        }
//        if self.title == "Twitter" {
//            self.products = twitterPro
//            self.wkViewController = WkView()
//            self.wkViewController?.urlString = "https://twitter.com"
//            self.navigationController?.pushViewController(self.wkViewController!, animated: true)
//            return
//        }
//        if self.title == "Tesla" {
//            self.products = teslaPro
//            self.wkViewController = WkView()
//            self.wkViewController?.urlString = "https://tesla.com"
//            self.navigationController?.pushViewController(self.wkViewController!, animated: true)
//           return
//        }
//        if self.title == "Google" {
//            self.products = googlePro
//            self.wkViewController = WkView()
//            self.wkViewController?.urlString = "https://google.com"
//            self.navigationController?.pushViewController(self.wkViewController!, animated: true)
//         return
//        }
//        self.tableView.reloadData()
        let row = indexPath.row
        print("Row: \(row)")
        
//        self.wkViewController = WkView()
////        self.wkViewController?.urlString = "https://apple.com"
//        self.navigationController?.pushViewController(self.wkViewController!, animated: true)
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

