//
//  AddEditVC.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 11/8/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit


class AddEditVC : UIViewController{
            var companyIndex: Int!
            var companyAssigned: CompanyCore?
    
    var tableData = [CompanyCore]()
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var initialText: UITextField!
    @IBOutlet weak var tickerText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(toggleSaveMode))
        self.navigationItem.rightBarButtonItem = saveButton

        self.registerForKeyboardNotifications()
        self.deregisterFromKeyboardNotifications()
        
        
        
     }
    
    
    func keyboardWasShown(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            animateViewMoving(up: true, moveValue: 120)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            animateViewMoving(up: false, moveValue: 120)
        
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        nameText.text = CDC.sharedInstance.selectedCompany?.name
        initialText.text = CDC.sharedInstance.selectedCompany?.logo
        tickerText.text = CDC.sharedInstance.selectedCompany?.ticker
        
        if companyAssigned == nil{ // new company - called from toggleAddMode() - assigning nil to companyAssigned
            nameText.placeholder! = "ADD COMPANY HERE"
            initialText.placeholder! = "ADD URL HERE"
            tickerText.placeholder! = "ADD TICKER HERE"
            self.title = "Add Company"
        } else {
            let logo = companyAssigned?.logo
            let name = companyAssigned?.name
            let ticker = companyAssigned?.ticker
            nameText.text! = name!
            initialText.text! = logo!
            tickerText.text! = ticker!
            self.title = "Edit Company"
        }
    }

    func toggleSaveMode() {
        if companyAssigned == nil{ // new company - called from toggleAddMode() - assigning nil to companyAssigned
            CDC.sharedInstance.saveCompanyToCoreData(name: nameText.text!, logo: initialText.text!, ticker: tickerText.text!, price: 0.0)
            
        } else {
            CDC.sharedInstance.updateCompany(newName: nameText.text!, newTicker: tickerText.text!, newURL: initialText.text!)
            self.tableData = CDC.sharedInstance.companies
        }
        self.navigationController?.popViewController(animated: true)
        }


   
}

