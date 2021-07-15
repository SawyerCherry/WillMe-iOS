//
//  UserDetailViewController.swift
//  WillMe iOS
//
//  Created by Sawyer Cherry on 7/13/21.
//

import UIKit
import CoreData
class UserDetailViewController: UIViewController {
    
    // MARK: - CoreData
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var user: PersonalInfo!
    var insurance: Insurance!
    var funeralHome: FuneralHome!
    
    
    lazy var editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .equalSpacing
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "First Last"
        lbl.font = UIFont(name: "Helvetica-Light", size: 30.0)
        return lbl
    }()
    let dOBLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Date Of Birth"
        lbl.font = UIFont(name: "Helvetica-Light", size: 20.0)
        return lbl
    }()
    let ssnLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Social Security #"
        lbl.font = UIFont(name: "Helvetica-Light", size: 20.0)
        return lbl
    }()
    
    var insuranceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let insuranceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Insurance Provider:"
        lbl.font = UIFont(name: "Helvetica-Light", size: 23.0)
        return lbl
    }()
    let insuranceNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Add an Insurance Provider"
        lbl.textColor = UIColor(named: "spearmint")
        lbl.isUserInteractionEnabled = true
        lbl.font = UIFont(name: "Helvetica-Light", size: 20.0)
        return lbl
    }()
    
    var funeralStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let funeralHomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Funeral Home:"
        lbl.font = UIFont(name: "Helvetica-Light", size: 23.0)
        return lbl
    }()
    let funeralHomeNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Add a Funeral Home"
        lbl.textColor = UIColor(named: "spearmint")
        lbl.isUserInteractionEnabled = true
        lbl.font = UIFont(name: "Helvetica-Light", size: 20.0)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Information"
        self.view.backgroundColor = .systemBackground
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
       
        setupUI()
        setupUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.saveContext()
    }
    
    convenience init(user: PersonalInfo) {
        self.init()
        self.user = user
    }

    
    func setupUserInfo() {
        guard let firstName = user.firstName, let lastName = user.lastName, let dateOfBirth = user.dateOfBirth, let _ = user.ssn else {
            print("Error fetching user info")
            return
        }
        nameLabel.text = "\(firstName) \(lastName)"
        dOBLabel.text = "Date Of Birth: \(dateFormatter.string(from: dateOfBirth))"
        ssnLabel.text = "Social Security Number Saved"
        
        if let userInsurance = user.insurance {
            insuranceNameLabel.text = userInsurance.providerName
            self.insurance = userInsurance
            let tapExistingInsurance = UITapGestureRecognizer(target: self, action: #selector(existingInsuranceLabelPressed))
            insuranceNameLabel.addGestureRecognizer(tapExistingInsurance)
        } else {
            let tapInsurance = UITapGestureRecognizer(target: self, action: #selector(newInsuranceLabelPressed))
            insuranceNameLabel.addGestureRecognizer(tapInsurance)
        }
        
        if let userFuneralHome = user.funeralHome {
            funeralHomeNameLabel.text = userFuneralHome.homeName
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
//            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            container.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -60),
            container.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.55),
            container.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            container.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
        ])
        
        container.addArrangedSubview(userStackView)
        container.addArrangedSubview(insuranceStackView)
        container.addArrangedSubview(funeralStackView)

        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(dOBLabel)
        userStackView.addArrangedSubview(ssnLabel)
        
        insuranceStackView.addArrangedSubview(insuranceLabel)
        insuranceStackView.addArrangedSubview(insuranceNameLabel)
        
        funeralStackView.addArrangedSubview(funeralHomeLabel)
        funeralStackView.addArrangedSubview(funeralHomeNameLabel)
        
//        container.addArrangedSubview(nameLabel)
//        container.addArrangedSubview(dOBLabel)
//        container.addArrangedSubview(ssnLabel)
//        container.addArrangedSubview(insuranceLabel)
//        container.addArrangedSubview(insuranceNameLabel)
//        container.addArrangedSubview(funeralHomeLabel)
//        container.addArrangedSubview(funeralHomeNameLabel)
    }
    
    // MARK: - Objc Button Functions
    @objc func editButtonPressed() {
        let nextVC = PersonalInfoViewController(user: user, adding: false)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /// To insurance detail view
    @objc func newInsuranceLabelPressed() {
//        let newInsurance = Insurance(context: managedContext)
        user.insurance = Insurance(context: managedContext)
        let nextVC = InsuranceViewController(insurance: user.insurance!, adding: true)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func existingInsuranceLabelPressed() {
        let nextVC = InsuranceViewController(insurance: self.insurance, adding: false)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /// To funeral home detail view
    @objc func newFuneralHomePressed() {
        user.funeralHome = FuneralHome(context: managedContext)
        let nextVC = FuneralHomeViewController(funeralHome: user.funeralHome!, adding: true)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func existingFuneralHomePressed() {
        let nextVC = FuneralHomeViewController(funeralHome: self.funeralHome, adding: false)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


