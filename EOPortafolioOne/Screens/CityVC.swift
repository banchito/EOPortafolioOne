//
//  CityVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/1/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit
import CoreLocation

class CityVC: UIViewController {
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    var itemViews: [UIView] = []
    
    var city : String!
    
    var lat  : CLLocationDegrees!
    var lon  : CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        if city == nil{
            getWeatherBy(latitude: lat, longitude: lon)
        } else {
            getWeatherWith(city: city)
        }
        layoutUI()
        
    }
    
    
    func getWeatherBy(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        NetworkManager.shared.getWeatherBylocation(latitude: latitude, longitude: longitude) {result in
            
            switch result {
                
            case .success(let weather):
                DispatchQueue.main.async {
                    self.title = weather.cityName
                    self.add(childVC: BoltWeatherInfoHeaderVC(weather: weather), to: self.headerView)
                    self.add(childVC: BoltMinMaxVC(weather: weather), to: self.itemViewOne)
                }
                print(weather)
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Oups", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func getWeatherWith(city: String) {

        NetworkManager.shared.getWeatherByCity(for: city) { result in
            switch result {
                
            case .success(let weather):
                DispatchQueue.main.async {
                    self.add(childVC: BoltWeatherInfoHeaderVC(weather: weather), to: self.headerView)
                    self.add(childVC: BoltMinMaxVC(weather: weather), to: self.itemViewOne)
                }
                print(weather)
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Oups", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureViewController()  {
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func layoutUI()   {
        
        itemViews = [headerView, itemViewOne]
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140)
        ])
        
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
