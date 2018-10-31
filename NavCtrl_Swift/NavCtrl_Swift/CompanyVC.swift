//
//  CompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit

class CompanyVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var companyList : [String]?
    var productViewController : ProductVC?
let logos = ["img-companyLogo_Apple","img-companyLogo_Twitter", "img-companyLogo_Tesla","img-companyLogo_Google"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.companyList = ["Apple","Twitter","Tesla","Google"]
        
        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        
        self.title = "Mobile Device Makers"
        // Do any additional setup after loading the view.
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            companyList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: delegate & datasource methods

extension CompanyVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let companyCount = self.companyList?.count {
            return companyCount
        } else {
            print("unknown number of rows... companyList is nil!")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) ??
        UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        
        cell.imageView?.image = UIImage.init(named: (logos[indexPath.row] + ".jpg"))
        if let currentCompanyName = self.companyList?[indexPath.row] {
            cell.textLabel?.text = currentCompanyName
        } else {
            cell.textLabel?.text = "?"
        }
        
       return cell
    }
    
    
    // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productViewController = ProductVC()
        if indexPath.row == 0 {
            self.productViewController?.title = "Apple"
        }
        if indexPath.row == 1 {
            self.productViewController?.title = "Twitter"
        }
        if indexPath.row == 2 {
            self.productViewController?.title = "Tesla"
        }
        if indexPath.row == 3 {
            self.productViewController?.title = "Google"
        }
        self.navigationController?.pushViewController(self.productViewController!, animated: true)
    }

 


    
    


}
