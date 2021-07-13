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
    
    
    
    let welcomeMessage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    let firstNameField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        return first
    }()
    
    let lastNameField: UITextField = {
        let last = UITextField()
        last.translatesAutoresizingMaskIntoConstraints = false
        last.textAlignment = .center
        return last
    }()
    
    let ssnField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var dOBField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
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
        
    }
    
    @objc func saveButtonPressed() {
        self.navigationController?.topViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func setWelcomeMessage(){
        self.view.addSubview(welcomeMessage)
        welcomeMessage.text = "Welcome to willMe, we are happy to have you!"
        welcomeMessage.font = UIFont(name: "Helvetica", size: 20.0)
//        NSLayoutConstraint.activate ([
//            welcomeMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            welcomeMessage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
    }

}
