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
    let cellIdentifier = "userCell"
    lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        // Create our managed context object by getting the context from the persistent container in the shared AppDelegae
        // Turns out we're doing this another dozen times.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
                                
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
        setupUI()
    }
    
    private func setupUI() {
        self.title = "WillMe Family"
        self.view.addSubview(usersTableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Profile", style: .plain, target: self, action: #selector(addUserButtonPressed))

        
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20),
            usersTableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    
    @objc func addUserButtonPressed() {
        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = PersonalInfoViewController(user: newPerson, adding: true)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    
}


extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {return 0}
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
        let user = fetchedResultsController.object(at: indexPath)
        cell.configure(name: "\(user.firstName ?? "name missing") \(user.lastName ?? "last name missing")")
                
        cell.backgroundColor = .systemBackground
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleting")
            let userToDelete = fetchedResultsController.object(at: indexPath)
            
            managedContext.delete(userToDelete)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            appDelegate.saveContext()
        
            usersTableView.reloadData()
        } else if editingStyle == .insert {
            print("How'd you get here?")
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = fetchedResultsController.object(at: indexPath)
        let nextVC = UserDetailViewController(user: user)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension UsersViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        usersTableView.reloadData()
    }
}
