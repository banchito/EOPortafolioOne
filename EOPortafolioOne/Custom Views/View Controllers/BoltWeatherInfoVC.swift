//
//  BoltWeatherInfoVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/8/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltWeatherInfoVC: UIViewController {

    let cityNameLabel        = BoltTitleLabel(textAlignment: .center, fontSize: 34)
    let weatherImageView     = UIImageView()
    let temperatureLabel     = BoltSecondaryTitleLabel(fontSize: 20)
    let feelsLikeLabel       = BoltBodyLabel(textAlignment: .center)
    
    
    var weather: WeatherModel!
    
    init (weather: WeatherModel){
        super.init(nibName:nil, bundle: nil)
        self.weather = weather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
        
    }
    
    
    func configureUIElements(){
        weatherImageView.image      = UIImage(systemName: weather.conditionName)
        weatherImageView.tintColor  = .secondaryLabel
        temperatureLabel.text       = weather.temperatureString
        feelsLikeLabel.text         = weather.feelsString
    }
    
    
    func addSubviews(){
        view.addSubview(weatherImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(feelsLikeLabel)
    }
    
    
    func layoutUI(){
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:padding),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weatherImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherImageView.heightAnchor.constraint(equalToConstant: 120),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: padding),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: textImagePadding),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textImagePadding),
            feelsLikeLabel.widthAnchor.constraint(equalToConstant: 80),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
