//
//  ViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/6/21.
//

import UIKit
import CoreData

class UsersViewController: UIViewController {
    
    // MARK: - CoreData
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController<PersonalInfo> = {
        let fetchRequest: NSFetchRequest<PersonalInfo> = PersonalInfo.fetchRequest()
        // Put sort descriptors here later
//        fetchRequest.sortDescriptors = []
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    // MARK: - UI Elements
    let addUserButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserButtonPressed))
        return button
    }()
    lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        tableView.delegate = self
        tableView.dataSource = self
        // MARK: - TODO: MAYBE ADD SOMETHING HERE
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create our managed context object by getting the context from the persistent container in the shared AppDelegae
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
        
    }
    
    @objc func addUserButtonPressed() {
        print("Create New User")
    }
    
//    func setupUser() {
//        if firstLaunch ==  true {
//            userInsurance = Insurance(context: managedContext)
//            userInsurance.hasInsurance = false
//            userFuneralHome = FuneralHome(context: managedContext)
//            userFuneralHome.preNeedsSet = false
//        } else {
//            userInsurance = currentUser.insurance
//            userFuneralHome = currentUser.funeralHome
//        }
    

}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {return 0}
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        return cell
    }
    
}

extension UsersViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        usersTableView.reloadData()
    }
}
