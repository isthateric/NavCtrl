//
//  CompanyVC.swift
//  NavCtrl_Swift
//
//  Created by Jesse Sahli on 2/22/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import UIKit
import CoreData

class CompanyVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var undoRedoView: UIView!
    
    var tableData = [CompanyCore]()
    var productViewController : ProductVC?
    let addEditView = AddEditVC()
    var stockFetcher = StockFetcher()
    var imageFetcher = ImageFetcher()
    let reuseIdentifier = "Cell"



    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.undoRedoView.isHidden = true
        
        self.stockFetcher.delegate = self
 
        //create edit button
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        let addBarButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(toggleAddMode))
        self.navigationItem.rightBarButtonItem = editBarButton
        self.navigationItem.leftBarButtonItem = addBarButton
        self.title = "Company List"

        self.tableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableData = CDC.sharedInstance.companies

        for company in tableData {
            let tickerName = company.ticker
            stockFetcher.fetchStockPriceForTicker(tickerName: tickerName ?? "NO TIcker")
       }
        
      //  tableView.reloadData()
        
     }
    
 


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
    }

    func toggleEditMode() {
     if self.navigationItem.rightBarButtonItem?.title == "Edit" {
        self.tableView.setEditing(true, animated: true)
        self.tableView.allowsSelectionDuringEditing = true
        self.undoRedoView.isHidden = false
        self.navigationItem.rightBarButtonItem?.title = "Done"
    } else {
        self.undoRedoView.isHidden = true
        self.tableView.setEditing(false, animated: true)
        self.tableView.allowsSelectionDuringEditing = false
        self.navigationItem.rightBarButtonItem?.title = "Edit"
      }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == UITableViewCellEditingStyle.delete{
     CDC.sharedInstance.deleteCompanyFromCoreData(index: indexPath.row)
     self.tableData = CDC.sharedInstance.companies
     self.tableView.reloadData()
        
        // 1)
       // let task = CDC.sharedInstance.companies.remove(at: indexPath.row)
        
        // 2)
      //  saveToCoreData(task: task)
        
        // 3)
        //tableView.beginUpdates()
       // tableView.deleteRows(at: [indexPath], with: .fade)
       // tableView.endUpdates()
    }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("called cellFor")

        let company = tableData[indexPath.row]



        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if (cell == nil)
        {
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
        reuseIdentifier: reuseIdentifier)
        }
        let cellData = "\(company.name ?? "") \(company.ticker ?? "NO TICKER")"
       // let urlo = CDC.sharedInstance.selectedCompany?.logo
        let imageurl = "\(company.logo ?? "")"
        cell?.textLabel?.text = cellData
        cell?.detailTextLabel?.text = String(company.price)
        cell?.imageView?.image = UIImage.init(named: "emptystate-homeView")
        var imageName = imageurl
        imageFetcher.fetchCompanyImageFor(domain: imageName ?? "no url", imageView: cell?.imageView)
        
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let company = tableData[indexPath.row]

    CDC.sharedInstance.selectedCompany = company

    if  self.tableView.isEditing == true {
    self.addEditView.companyAssigned = company
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(self.addEditView, animated: false)
    }
    else {


    self.productViewController = ProductVC()
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(self.productViewController!, animated: false)
    }
        
        
    }

    func toggleAddMode(){
    // Open AddEditVC for new company
    CDC.sharedInstance.selectedCompany = nil
    self.addEditView.companyAssigned = nil
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)

    self.navigationController?.pushViewController(self.addEditView, animated: false)

    self.tableData = CDC.sharedInstance.companies
        
    }

    @IBAction func redoButton(_ sender: Any) {
        CDC.sharedInstance.redo()
        self.tableData = CDC.sharedInstance.companies
        tableView.reloadData()

    }
    
    @IBAction func undoButton(_ sender: Any) {
        
        CDC.sharedInstance.undo()
        self.tableData = CDC.sharedInstance.companies
        tableView.reloadData()
        
    }
 
 
    }


    extension CompanyVC : StockFetcherDelegate {
    func priceIsHere() {
        self.tableData = CDC.sharedInstance.companies
        tableView.reloadData()
    }


    func stockFetchSuccessWithPriceString(Company: CompanyCore, price: String ) { // get both price and row
    print("Stock price received ", price)
    //self.priceLabel.text = "$\(price)"

    CDC.sharedInstance.selectedCompany = Company
    Company.price = Double(price)!
    }

    func stockFetchDidFailWithError(error: Error) {
    print("Could not fetch stock price, this is a description of the error: \(error.localizedDescription)")
    }

    func stockFetchDidStart() {
    print("Initiating stock fetch...")
    //could start an activity indicator here, etc.
    }

    }




