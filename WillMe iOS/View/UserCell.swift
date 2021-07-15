//
//  UserCell.swift
//  WillMe iOS
//
//  Created by Rick Jacobson on 7/15/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    var colorLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "seaBlue")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "First Last"
        lbl.font = UIFont(name: "Helvetica-Light", size: 25.0)
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(name: String) {
        self.contentView.addSubview(colorLayer)
        NSLayoutConstraint.activate([
            colorLayer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            colorLayer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7),
            colorLayer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            colorLayer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        colorLayer.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: colorLayer.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: colorLayer.rightAnchor, constant: -5),
            nameLabel.centerYAnchor.constraint(equalTo: colorLayer.centerYAnchor)
        ])
        
        nameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
