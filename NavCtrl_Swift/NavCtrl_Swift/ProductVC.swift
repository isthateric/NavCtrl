//
//  ProductVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import WebKit

class ProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    var products: [ProductCore]?
    
    
    var companyData = [CompanyCore]()
    let addEditproduct = AddEditProductVC()
    var imageFetcher = ImageFetcher()
    var company1 = [CompanyCore]()

    
    
    var product = ProductCore?.self
    var wkViewController: WkView?
    let web = WKWebView()
    
//    var newProductListed: [Product]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.companyData = CDC.sharedInstance.companies
        
       var name = CDC.sharedInstance.selectedCompany?.name
        var logo = CDC.sharedInstance.selectedCompany?.logo
            let imageurl = "\(logo ?? "")"
            var imageName = imageurl
            productLabel.text = name
            imageFetcher.fetchCompanyImageFor(domain: imageName ?? "no url", imageView: imageView)
        
        
           
        let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(toggleAddMode))
            self.navigationItem.rightBarButtonItem = addBarButton
        self.tableView.reloadData()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        products =  CDC.sharedInstance.getProductsFor()
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
    
    
    func toggleAddMode(){
        self.addEditproduct.productAssigned = nil
        addEditproduct.isAdding = true
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(self.addEditproduct, animated: false)

    }
    






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
        let product = products![indexPath.row]
        let CellIdentifier = "Cell"
        let company = CDC.sharedInstance.selectedCompany

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        cell.textLabel?.text = product.name
        cell.imageView?.image = UIImage.init(named: "emptystate-homeView")
        let imageurl = "\(company?.logo ?? "")"

        var imageName = imageurl
        imageFetcher.fetchCompanyImageFor(domain: imageName ?? "no url", imageView: cell.imageView)
        return cell
    }
    
        

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let product = products?[indexPath.row] {
            
            CDC.sharedInstance.selectedProduct = product
            
            self.wkViewController = WkView()
            self.wkViewController?.urlString = product.url!
            
            let transition:CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype =  kCATransitionFromTop

            self.navigationController!.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.pushViewController(self.wkViewController!, animated: false)
            return 
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //  self.tableData = CDC.sharedInstance.companies
        
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            guard let products = products else { return }
            
            CDC.sharedInstance.productos = products
            CDC.sharedInstance.deleteProductFromCoreData(index: indexPath.row)
            self.products = CDC.sharedInstance.productos
            self.tableView.reloadData()
        }
    }
        
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      
        let item = products![sourceIndexPath.row]
        products?.remove(at: sourceIndexPath.row)
        products?.insert(item, at: destinationIndexPath.row)
    }
  
}

