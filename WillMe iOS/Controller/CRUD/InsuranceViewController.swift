//
//  InsuranceViewController.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/13/21.
//

import UIKit
import CoreData

class InsuranceViewController: UIViewController {
    
    // MARK: - CoreData
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var insurance: Insurance!
    var adding: Bool = true

    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillEqually
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let providerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Provider Name"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let providerField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "Provider Name"
        return first
    }()
    
    let policyNumLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Policy Number"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let policyNumField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "Policy Number"
        return first
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Insurance"
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("In InsuranceViewController.viewDidLoad")
        }
        managedContext = appDelegate.persistentContainer.viewContext
        
        setupUI()
    }
    
    convenience init(insurance: Insurance, adding: Bool) {
        self.init()
        self.insurance = insurance
        self.adding = adding
        
        if !adding {
            providerField.text = insurance.providerName
            policyNumField.text = insurance.policyNumber
        }
        return
    }
    

    private func setupUI(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        
        self.view.addSubview(container)
    
        NSLayoutConstraint.activate ([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
        ])
        container.addArrangedSubview(providerLabel)
        container.addArrangedSubview(providerField)
        container.addArrangedSubview(policyNumLabel)
        container.addArrangedSubview(policyNumField)
    }
   
    @objc func saveButtonPressed() {
        guard let name = providerField.text, let policy = policyNumField.text else {return}
        self.insurance.providerName = name
        self.insurance.policyNumber = policy
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("In InsuranceViewController.saveButtonPressed")
        }
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if adding {
            // Delete new Insurance from managedObjectContext
            managedContext.delete(insurance)
            
            // Still amazing how the managed context was saved successfully but I have to redeclare the AppDelegate every time.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("In InsuranceViewController.back")
            }
            appDelegate.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
}
