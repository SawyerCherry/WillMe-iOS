//
//  FuneralHomeViewController.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/13/21.
//

import UIKit

class FuneralHomeViewController: UIViewController {
    
    var user: PersonalInfo!
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
        
        return control
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    convenience init(user: PersonalInfo, funeralHome: FuneralHome, adding: Bool) {
        self.init()
        self.user = user
        self.funeralHome = funeralHome
        self.adding = adding
        
        if !adding {
            funeralHomeField.text = funeralHome.homeName
//            preneedsControl
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
//            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -625),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])
        container.addArrangedSubview(funeralHomeLabel)
        container.addArrangedSubview(funeralHomeField)

        needsStack.addArrangedSubview(preneedsLabel)
        needsStack.addArrangedSubview(preneedsControl)
        
        NSLayoutConstraint.activate ([
            needsStack.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 125),
//            needsStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -275),
            needsStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            needsStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            preneedsControl.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 80.0),
            preneedsControl.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -80.0),
            preneedsLabel.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 50.0),
            preneedsLabel.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -50.0),
            
        ])
        
    }
    
    @objc func saveButtonPressed() {
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        
    }

}
