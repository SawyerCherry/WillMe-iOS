//
//  SetupProfileViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/13/21.
//

import UIKit
import CoreData

class PersonalInfoViewController: UIViewController {
    
//    var appDelegate: AppDelegate!
//    var managedContext: NSManagedObjectContext!
    
    var adding: Bool!
    var user: PersonalInfo!
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.alignment = .center
        
        container.distribution = .fillEqually
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let welcomeMessage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Welcome to willMe."
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let firstNameField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "First Name"
        return first
    }()
    
    let lastNameField: UITextField = {
        let last = UITextField()
        last.translatesAutoresizingMaskIntoConstraints = false
        last.textAlignment = .center
        last.placeholder = "Last Name"
        return last
    }()
    
    let ssnField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.placeholder = "Social Security Number"
        return textField
    }()
    
    lazy var dOBField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = -100
        datePicker.minimumDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -18
        datePicker.maximumDate = calendar.date(byAdding: comps, to: Date())
        return datePicker
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Profile"
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    convenience init(user: PersonalInfo, adding: Bool) {
        self.init()
        self.adding = adding
        self.user = user
        if !adding {
            firstNameField.text = user.firstName
            lastNameField.text = user.lastName
            ssnField.text = user.ssn
            dOBField.date = user.dateOfBirth!
        } else {
            return
        }
    }
    
    @objc func saveButtonPressed() {
        user.firstName = firstNameField.text
        user.lastName = lastNameField.text
        user.ssn = ssnField.text
        user.dateOfBirth = dOBField.date
        
        if adding{
            user.tasksCompleted = 4
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func back(sender: UIBarButtonItem) {
            // Perform your custom actions
            // To do: delete Personal Info Here
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if adding {
            managedContext.delete(user)
        }
        navigationController?.popViewController(animated: true)
    }

    
    func setupUI(){
        
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
        container.addArrangedSubview(welcomeMessage)
        container.addArrangedSubview(firstNameField)
        container.addArrangedSubview(lastNameField)
        container.addArrangedSubview(ssnField)
        container.addArrangedSubview(dOBField)
    }
    
    

}
