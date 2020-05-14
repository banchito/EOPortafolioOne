//
//  BoltItemInfoVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/12/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltItemInfoVC: UIViewController {
    
    let stackView           = UIStackView()
    let itemInfoViewOne     = BoltItemInfoView()
    let itemInfoViewTwo     = BoltItemInfoView()
    let itemInfoViewThree   = BoltItemInfoView()
    let itemInfoViewFour    = BoltItemInfoView()
    
    var weather:  WeatherModel!
    
    
    init (weather: WeatherModel){
        super.init(nibName:nil, bundle: nil)
        self.weather = weather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    
    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    
    private func configureStackView(){
        stackView.axis          = .horizontal
        stackView.distribution  = .fillEqually
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        stackView.addArrangedSubview(itemInfoViewThree)
        stackView.addArrangedSubview(itemInfoViewFour)
    }
    
    
    private func layoutUI()  {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}
