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
        let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    // MARK: - UI Elements

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
        self.title = "Home"
        // Create our managed context object by getting the context from the persistent container in the shared AppDelegae
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Profile", style: .plain, target: self, action: #selector(addUserButtonPressed) )
        setupTableView()
        
        
    }
    func setupTableView() {
        self.view.addSubview(usersTableView)
        
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    @objc func addUserButtonPressed() {
        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = AddOrEditProfileViewController(user: newPerson, adding: true)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    
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
