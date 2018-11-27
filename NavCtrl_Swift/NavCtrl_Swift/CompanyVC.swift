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
    var companyList: [Company]?
    var productViewController : ProductVC?
    let  addEditView = AddEditVC()
    var newCompanyListed: [Company]?
    
     override func viewDidLoad() {
        super.viewDidLoad()

        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        let addBarButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(toggleAddMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        self.navigationItem.leftBarButtonItem = addBarButton
        
        self.title = "Mobile Device Makers"
        
       // companyList = Dao.sharedInstance.companyArray
       // newCompanyListed = Dao.sharedInstance.createdCompany
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        companyList = Dao.sharedInstance.companyArray
        tableView.reloadData()
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
            }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            companyList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func toggleAddMode(){
        
        // Open AddEditVC for new company
        self.addEditView.companyAssigned = nil
        self.navigationController?.pushViewController(self.addEditView, animated: true)

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
        
//        cell.imageView?.image = UIImage.init(named: (logos[indexPath.row] + ".jpg"))
        if let currentCompanyName = self.companyList?[indexPath.row] {
            cell.imageView?.image = UIImage.init(named: currentCompanyName.logo)
            cell.textLabel?.text = currentCompanyName.name
        } else {
            cell.textLabel?.text = "?"
        }
            return cell
    }
      // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let currentCompany = companyList?[indexPath.row] else { return }
        
        
        if  self.tableView.isEditing == true {
            // Open AddEditVC for selected company
            self.addEditView.companyIndex = indexPath.row
            self.addEditView.companyAssigned = currentCompany
            self.navigationController?.pushViewController(self.addEditView, animated: true)
        }
        else {
            
            self.productViewController = ProductVC()
            productViewController?.title = currentCompany.name
            productViewController?.products = currentCompany.products
            self.navigationController?.pushViewController(self.productViewController!, animated: true)
        }
        
     }
}
