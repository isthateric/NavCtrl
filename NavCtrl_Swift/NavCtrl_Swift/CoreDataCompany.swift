//
//  CoreDataCompany.swift
//  NavCtrl_Swift
//
//  Created by Eric Fuentes on 12/11/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import UIKit
import CoreData



class CDC: NSObject{
    
    var companies = [CompanyCore]()
    var productos = [ProductCore]()
    static let sharedInstance = CDC()
    
    var selectedCompany : CompanyCore?
    var selectedProduct : ProductCore?
    
    private override init() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.undoManager = UndoManager()
        
        
        
        let fetchRequest = NSFetchRequest<CompanyCore>(entityName: "CompanyCore")
        do {
            companies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print( "Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func saveCompanyToCoreData(name: String, logo: String, ticker: String, price: Double){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CompanyCore",
                                                in: managedContext)!
        let company = CompanyCore(entity: entity,
                                      insertInto: managedContext)
        
        company.name = name
        company.logo = logo
        company.price = price
        company.ticker = ticker
        //company.setValue(name, forKeyPath: "name")
        
         
        do {
            try managedContext.save()
            companies.append(company)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    func deleteCompanyFromCoreData(index:Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let companyToDelete = self.companies[index]
        
        managedContext.delete(companyToDelete)
        do {
            try managedContext.save()
            companies.remove(at: index)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func updatePriceFor(ticker: String, price: Double) {
        
        
        for (index, company) in companies.enumerated() {
            if company.ticker == ticker {
                companies[index].price = price
                
            }
        }
        
    }
    func deleteProductFromCoreData(index:Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let productToDelete = self.productos[index]
        
        managedContext.delete(productToDelete)
        productos.remove(at: index)

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        
    }
    
    
    func addNewProduct(productName: String, productLogo: String, productURL: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductCore",
                                                in: managedContext)!
       
        let productCore = ProductCore(entity: entity,
                                      insertInto: managedContext)
        productCore.name = productName
        productCore.logo = productLogo
        productCore.url = productURL
        
        productCore.company = selectedCompany
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
     }
    
    
    func getProductsFor() -> [ProductCore]? {
        
        return selectedCompany?.products?.allObjects as? [ProductCore]
       
    }
    
    func updateImageFor(name: String) {
        selectedCompany?.name = name
    }
    
    func updateCompany(newName: String, newTicker: String, newURL: String){
    
        selectedCompany?.name = newName
        selectedCompany?.logo = newURL
        selectedCompany?.ticker = newTicker
     
    }
    func updateProduct(newName: String, newLogo: String, newURL: String){
     
        selectedProduct?.name = newName
        selectedProduct?.logo = newLogo
        selectedProduct?.url = newURL
     
    }


    func undo(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.undo()
        
        
        
        let fetchRequest = NSFetchRequest<CompanyCore>(entityName: "CompanyCore")
        do {
            companies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print( "Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func redo(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.redo()
        
        let fetchRequest = NSFetchRequest<CompanyCore>(entityName: "CompanyCore")
        do {
            companies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print( "Could not fetch. \(error), \(error.userInfo)")
        }
    }
    }
