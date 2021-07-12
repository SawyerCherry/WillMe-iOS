//
//  ViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/6/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // Using CoreData even though MVP functionality will only allow one user to make it easier to implement multiple users later
    
    var currentUser: PersonalInfo!
    var userInsurance: Insurance!
    var userFuneralHome: FuneralHome!
    
    var firstLaunch: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create our managed context object by getting the context from the persistent container in the shared AppDelegae
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //
        let userFetch: NSFetchRequest<PersonalInfo> = PersonalInfo.fetchRequest()
        do {
            let users = try managedContext.fetch(userFetch)
            currentUser = users[0]
        } catch let error as NSError {
            print("Either first launch or error fetching user \(error) \(error.userInfo)")
            print("Creating new")
            currentUser = PersonalInfo(context: managedContext)
            firstLaunch = true
        }
        
        setupUser(managedContext)
        
    }
    
    func setupUser(_ context: NSManagedObjectContext) {
        if firstLaunch ==  true {
            userInsurance = Insurance(context: context)
            userInsurance.hasInsurance = false
            userFuneralHome = FuneralHome(context: context)
            userFuneralHome.preNeedsSet = false
        } else {
            userInsurance = currentUser.insurance
            userFuneralHome = currentUser.funeralHome
        }
    }

}

