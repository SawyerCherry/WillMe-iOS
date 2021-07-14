//
//  FuneralHomeViewController.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/13/21.
//

import UIKit

class FuneralHomeViewController: UIViewController {

    var funeralHome: FuneralHome!
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
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
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let preneedsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Have you made arrangements?"
        lbl.font = UIFont(name: "Helvetica-Light", size: 20.0)
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
    
    private func setupUI(){
        
        self.view.addSubview(container)
        self.view.addSubview(needsStack)
        
    
        NSLayoutConstraint.activate ([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 45),
            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -625),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])
        container.addArrangedSubview(funeralHomeLabel)
        container.addArrangedSubview(funeralHomeField)
        needsStack.backgroundColor = .blue
        needsStack.addArrangedSubview(preneedsLabel)
        needsStack.addArrangedSubview(preneedsControl)
        
        NSLayoutConstraint.activate ([
            needsStack.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 125),
            needsStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -275),
            needsStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            needsStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            preneedsControl.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 80.0),
            preneedsControl.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -80.0),
            preneedsLabel.topAnchor.constraint(equalTo: needsStack.topAnchor, constant: 50.0),
            preneedsLabel.bottomAnchor.constraint(equalTo: needsStack.bottomAnchor, constant: -50.0),
        ])
        
       
        
    }
    


}
