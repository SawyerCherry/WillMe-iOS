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
    
    var user: PersonalInfo!
    var insurance: Insurance!
    var funeralHome: FuneralHome!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
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
        
        self.view.backgroundColor = .systemBackground
       
        setupUI()
        setupUserInfo()
    }
    
    convenience init(user: PersonalInfo) {
        self.init()
        self.user = user
    }

    
    func setupUserInfo() {
        guard let firstName = user.firstName, let lastName = user.lastName, let dateOfBirth = user.dateOfBirth, let ssn = user.ssn else {
            print("Error fetching user info")
            return
        }
        nameLabel.text = "\(firstName) \(lastName)"
        dOBLabel.text = dateFormatter.string(from: dateOfBirth)
        ssnLabel.text = ssn
        
        if let userInsurance = user.insurance {
            insuranceNameLabel.text = insurance.providerName
            self.insurance = userInsurance
            let tapExistingInsurance = UITapGestureRecognizer(target: self, action: #selector(existingInsuranceLabelPressed))
            insuranceNameLabel.addGestureRecognizer(tapExistingInsurance)
        } else {
            let tapInsurance = UITapGestureRecognizer(target: self, action: #selector(newInsuranceLabelPressed))
            insuranceNameLabel.addGestureRecognizer(tapInsurance)
        }
        
        if let userFuneralHome = user.funeralHome {
            funeralHomeNameLabel.text = funeralHome.homeName
            self.funeralHome = userFuneralHome
            let tapExistingFuneralHome = UITapGestureRecognizer(target: self, action: #selector(existingFuneralHomePressed))
            funeralHomeNameLabel.addGestureRecognizer(tapExistingFuneralHome)
        } else {
            let tapFuneralHome = UITapGestureRecognizer(target: self, action: #selector(newFuneralHomePressed))
            funeralHomeNameLabel.addGestureRecognizer(tapFuneralHome)
        }
        
    }
    
    private func setupUI() {
        
        self.navigationItem.rightBarButtonItem = editButton
        
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
    
    @objc func editButtonPressed() {
        let nextVC = PersonalInfoViewController(user: user, adding: false)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func newInsuranceLabelPressed() {
//        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = InsuranceViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func newFuneralHomePressed() {
//        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = FuneralHomeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func existingInsuranceLabelPressed() {
//        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = InsuranceViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func existingFuneralHomePressed() {
//        let newPerson = PersonalInfo(context: managedContext)
        let nextVC = FuneralHomeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


