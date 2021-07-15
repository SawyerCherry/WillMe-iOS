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
        container.distribution = .equalSpacing
        container.alignment = .center
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    var providerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let providerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Provider Name"
        lbl.font = UIFont(name: "Helvetica-Light", size: 30.0)
        return lbl
    }()
    let providerField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "Provider Name"
        first.backgroundColor = UIColor(named: "darkSeaBlue")
        first.font = UIFont(name: "Helvetica-Light", size: 24.0)
        first.layer.cornerRadius = 10
        return first
    }()
    
    var policyStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let policyNumLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Policy Number"
        lbl.font = UIFont(name: "Helvetica-Light", size: 30.0)
        return lbl
    }()
    let policyNumField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "Policy Number"
        first.backgroundColor = UIColor(named: "darkSeaBlue")
        first.font = UIFont(name: "Helvetica-Light", size: 24.0)
        first.layer.cornerRadius = 10
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
            container.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -60),
            container.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
        ])
        
        container.addArrangedSubview(providerStack)
        container.addArrangedSubview(policyStack)
        
        providerStack.addArrangedSubview(providerLabel)
        providerStack.addArrangedSubview(providerField)
        providerField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        policyStack.addArrangedSubview(policyNumLabel)
        policyStack.addArrangedSubview(policyNumField)
        policyNumField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
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
