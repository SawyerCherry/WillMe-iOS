//
//  SetupProfileViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/13/21.
//

import UIKit
import CoreData

class SetupProfileViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
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
//        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        setupUI()
        
    }
    
    @objc func saveButtonPressed() {
        self.navigationController?.topViewController?.dismiss(animated: true, completion: nil)
        
    }

    
    func setupUI(){
        self.view.addSubview(container)
    
        NSLayoutConstraint.activate ([
//            container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            container.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
//            container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
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
