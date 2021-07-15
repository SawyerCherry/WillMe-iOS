//
//  FuneralHomeViewController.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/13/21.
//

import UIKit
import CoreData

class FuneralHomeViewController: UIViewController {
    
    // MARK: - CoreData
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var funeralHome: FuneralHome!
    var adding: Bool = true
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 20
        container.distribution = .equalSpacing
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let funeralHomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Funeral Home:"
        lbl.font = UIFont(name: "Helvetica-Light", size: 35.0)
        return lbl
    }()
    let funeralHomeField: UITextField = {
        let first = UITextField()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.textAlignment = .center
        first.placeholder = "Funeral Home Name"
        return first
    }()
    
    let needsStack: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 0
        container.distribution = .equalSpacing
        container.alignment = .center
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let preneedsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Have you made arrangements?"
        lbl.font = UIFont(name: "Helvetica-Light", size: 15.0)
        return lbl
    }()
    
    let preneedsControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Yes", "No"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = UIColor(named: "spearmint")
        control.backgroundColor = UIColor(named: "darkSpearmint")
        return control
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("In FuneralHomeViewController.viewDidLoad")
        }
        managedContext = appDelegate.persistentContainer.viewContext
        
        preneedsControl.addTarget(self, action: #selector(changeAnswer(sender:)), for: .valueChanged)
        setupUI()
    }
    
    convenience init(funeralHome: FuneralHome, adding: Bool) {
        self.init()
        self.funeralHome = funeralHome
        self.adding = adding
        
        if !adding {
            funeralHomeField.text = funeralHome.homeName
            switch funeralHome.preNeedsSet {
            case true:
                print("Trying to set SegmentedControl to 'Yes'")
                preneedsControl.selectedSegmentIndex = 0
            case false:
                print("Trying to set SegmentedControl to 'No")
                preneedsControl.selectedSegmentIndex = 1
            }
        }
        return
    }
    
    private func setupUI(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        
        self.view.addSubview(container)
        self.view.addSubview(needsStack)
        
    
        NSLayoutConstraint.activate ([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 45),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])
        container.addArrangedSubview(funeralHomeLabel)
        container.addArrangedSubview(funeralHomeField)

        needsStack.addArrangedSubview(preneedsLabel)
        needsStack.addArrangedSubview(preneedsControl)
        
        NSLayoutConstraint.activate ([
            needsStack.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 125),
            needsStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            needsStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            preneedsControl.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 80.0),
            preneedsControl.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -80.0),
            preneedsLabel.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 50.0),
            preneedsLabel.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -50.0),
            
        ])
                
    }
    
    @objc func changeAnswer(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            funeralHome.preNeedsSet = true
            print("Preneeds set to true")
        case 1:
            funeralHome.preNeedsSet = false
            print("Preneeds set to false")
        default:
            print("You shouldn't be here")
        }
    }
    
    @objc func saveButtonPressed() {
        // Set the home's name to the string in the TextField
        guard let name = funeralHomeField.text else {
            fatalError("Where's the name?!?!")
        }
        funeralHome.homeName = name
//        user.funeralHome?.homeName = name
        // Make sure the home is linked to the user
//        user.funeralHome = funeralHome
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("In FuneralHomeViewController.saveButtonPressed")
        }
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if adding {
            // Delete new funeralHome from managedObjectContext
            managedContext.delete(funeralHome)
            
            // Amazing how the managed context was saved successfully but I have to redeclare the AppDelegate every time.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("In FuneralHomeViewController.back")
            }
            appDelegate.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }

}
