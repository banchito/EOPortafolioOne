//
//  BoltItemInfoView.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/10/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case min, max, sunrise, sunset 
}

class BoltItemInfoView: UIView {

    let symbolImageView  = UIImageView()
    let weatherInfoLabel = BoltTitleLabel(textAlignment: .center, fontSize: 14)
    
    var weather: WeatherModel!
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(weatherInfoLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode                               = .scaleAspectFit
        weatherInfoLabel.contentMode                              = .scaleAspectFit
        symbolImageView.tintColor                                 = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 40),
            symbolImageView.heightAnchor.constraint(equalToConstant: 40),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            weatherInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weatherInfoLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType: ItemInfoType, withInfo info: String){
           switch itemInfoType {
           case .min:
            symbolImageView.image = UIImage(systemName: sfSymbols.min.rawValue)
            weatherInfoLabel.text = info
           case .max:
            symbolImageView.image = UIImage(systemName: sfSymbols.max.rawValue)
            weatherInfoLabel.text = info
           case .sunrise:
            symbolImageView.image = UIImage(systemName: sfSymbols.sunrise.rawValue)
            weatherInfoLabel.text = info
           case .sunset:
            symbolImageView.image = UIImage(systemName: sfSymbols.sunset.rawValue)
            weatherInfoLabel.text = info
           }
       }
}
