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
    
    let headerView = UIView()
        
    var city: String!
    var lat : CLLocationDegrees!
    var lon : CLLocationDegrees!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
       
        
        NetworkManager.shared.getWeatherBylocation(latitude: lat, longitude: lon) {result in
            
            switch result {
                
            case .success(let weather):
                DispatchQueue.main.async {
                    self.title = weather.name
                    //self.add(childVC: BoltWeatherInfoVC(weather: weather), to: headerView)
                }
                print(weather)
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Bad Stuff happened.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func layoutUI()   {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 250)
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
