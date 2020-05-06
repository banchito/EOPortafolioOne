//
//  CityVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/1/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class CityVC: UIViewController {
        
    var city: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        NetworkManager.shared.getWeather(for: city) { (weather, errorMessage) in
            guard let weather = weather else {
                self.presentBoltAlertOnMainThread(title: "Bad Stuff happened.", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            print(weather)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
   

}
