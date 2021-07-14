//
//  InsuranceViewController.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/13/21.
//

import UIKit

class InsuranceViewController: UIViewController {

    var insurance: Insurance!
    
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
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
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
   

}
