//
//  UserDetailViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/13/21.
//

import UIKit
import CoreData
class UserDetailViewController: UIViewController {
    
    lazy var editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillEqually
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "First Last"
        lbl.font = UIFont(name: "Helvetica", size: 30.0)
        return lbl
    }()
    
    let dOBLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Date Of Birth"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let ssnLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Social Security #"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let insuranceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Insurance Provider:"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let insuranceNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Add an Insurance Provider"
        lbl.isUserInteractionEnabled = true
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let funeralHomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Funeral Home:"
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    let funeralHomeNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Add a Funeral Home"
        lbl.isUserInteractionEnabled = true
        lbl.font = UIFont(name: "Helvetica", size: 20.0)
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Information"
       
    }
    
    @objc func editButtonPressed() {
        
    }
    
    private func setupUI() {
        
        self.view.addSubview(container)
    
        NSLayoutConstraint.activate ([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
        ])
        
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(dOBLabel)
        container.addArrangedSubview(ssnLabel)
        container.addArrangedSubview(insuranceLabel)
        container.addArrangedSubview(insuranceNameLabel)
        container.addArrangedSubview(funeralHomeLabel)
        container.addArrangedSubview(funeralHomeNameLabel)
        
    }
}


