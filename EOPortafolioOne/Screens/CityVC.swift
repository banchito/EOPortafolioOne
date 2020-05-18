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
        NetworkManager.shared.getWeatherBylocation(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else {return}
             
            switch result {
                
            case .success(let weather):
                DispatchQueue.main.async {
                    self.title = weather.cityName
                    self.city  = weather.cityName.replacingOccurrences(of: " ", with: "+")
                    self.add(childVC: BoltWeatherInfoHeaderVC(weather: weather), to: self.headerView)
                    self.add(childVC: BoltMinMaxVC(weather: weather), to: self.itemViewOne)
                    
                }
               
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Oups", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func getWeatherWith(city: String) {
        
        NetworkManager.shared.getWeatherByCity(for: city) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
               
            case .success(let weather):
                
                DispatchQueue.main.async {
                    self.city  = weather.cityName.replacingOccurrences(of: " ", with: "+")
                    self.add(childVC: BoltWeatherInfoHeaderVC(weather: weather), to: self.headerView)
                    self.add(childVC: BoltMinMaxVC(weather: weather), to: self.itemViewOne)
                   
                }
               
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Oups", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureViewController()  {
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
    
    
    @objc func addButtonTapped() {
        
        NetworkManager.shared.getCityInfo(for: city) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let city):
                
                let favorite = City(name: city.name, cityId: city.cityId)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentBoltAlertOnMainThread(title: "Success!", message: "You have succesfully favorited this city", buttonTitle: "Ok")
                        return
                    }
                    self.presentBoltAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
               
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
