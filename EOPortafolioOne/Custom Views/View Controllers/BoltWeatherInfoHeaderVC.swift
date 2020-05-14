//
//  BoltWeatherInfoVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/8/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltWeatherInfoHeaderVC: UIViewController {

    let cityNameLabel        = BoltTitleLabel(textAlignment: .center, fontSize: 34)
    let weatherImageView     = UIImageView()
    let temperatureLabel     = BoltTitleLabel(textAlignment: .center, fontSize: 34)
    let feelsLikeLabel       = BoltSecondaryTitleLabel(fontSize: 20)
    
    
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
        temperatureLabel.text       =  weather.description + " " + weather.temperatureString + "°"
        feelsLikeLabel.text         = "Feels like \(weather.feelsString)°"
    }
    
    
    func addSubviews(){
        view.addSubview(weatherImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(feelsLikeLabel)
    }
    
    
    func layoutUI(){
        let padding: CGFloat            = 10
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 150),
            weatherImageView.heightAnchor.constraint(equalToConstant: 120),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -20),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -60),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeLabel.widthAnchor.constraint(equalToConstant: 100),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
