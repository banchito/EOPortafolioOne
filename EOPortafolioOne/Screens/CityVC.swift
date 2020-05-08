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
        
    var city: String!
    var lat : CLLocationDegrees!
    var lon : CLLocationDegrees!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        NetworkManager.shared.getWeatherBylocation(latitude: lat, longitude: lon) {result in
            
            switch result {
                
            case .success(let weather):
                DispatchQueue.main.async { self.title = weather.name}
                
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Bad Stuff happened.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
   

}
