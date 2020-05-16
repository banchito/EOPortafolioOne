//
//  FavoriteCell.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/16/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = ReusableCell.favoritesCitiesCell.rawValue
    let cityNameLabel  = BoltTitleLabel(textAlignment: .left, fontSize: 26)
     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: City)  {
        cityNameLabel.text = favorite.name
    }
    
    
    private func configure(){
        addSubview(cityNameLabel)
        accessoryType        = .disclosureIndicator
        let padding: CGFloat =  12
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
}
