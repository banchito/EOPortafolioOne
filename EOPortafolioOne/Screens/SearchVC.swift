//
//  SearchVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 4/29/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
// 0ac83c5b6ba194a4fdb81d25ef69dc27


import UIKit
import CoreLocation


class SearchVC: UIViewController {
    
    let logoImageView           = UIImageView()
    let cityTextField           = BoltTextField()
    let gpsButton               = BoltButton(backgroundColor: .systemBackground, title: "")
    let callToActionButton      = BoltButton(backgroundColor: .systemIndigo, title: "Get Weather")
    let locationManager         = CLLocationManager()
    
    var weatherManager          = NetworkManager()
    var lon: CLLocationDegrees  = 0.0
    var lat: CLLocationDegrees  = 0.0
    
    var isLocationReceived: Bool = false
    
    var isCityNameEntered: Bool {
        return !cityTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        configureLogoImageView()
        configureCityTextField()
        configureGeoLocalizationButton()
        configureCallToActionButton()
        createDismissKeyBoardTapGesture()
        setupToolBar(on: cityTextField)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyBoardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushToCityVC(){
        if isLocationReceived == true{
            let cityVC              = CityVC()
            cityVC.lat              = lat
            cityVC.lon              = lon
            navigationController?.pushViewController(cityVC, animated: true)
        }
    }
    
    
    @objc func pushCityVC() {
        guard isCityNameEntered else {
            presentBoltAlertOnMainThread(title: "Empty City", message: "Please enter a city to get its weather. ", buttonTitle: "Ok")
            return
        }
        cityTextField.resignFirstResponder()
        
        let cityVC              = CityVC()
        if let cityNoSpace      = cityTextField.text{
        cityVC.city = cityNoSpace.replacingOccurrences(of: " ", with: "+")
        }
        cityVC.title            = cityTextField.text?.capitalized
        cityTextField.text      = ""
        navigationController?.pushViewController(cityVC, animated: true)
    }
    
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image     = Images.boltLogo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            logoImageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureGeoLocalizationButton(){
        view.addSubview(gpsButton)
        gpsButton.addTarget(self, action: #selector(pushToCityVC), for: .touchUpInside)
        
        gpsButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        gpsButton.tintColor = .systemIndigo
        
        NSLayoutConstraint.activate([
            gpsButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            gpsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            gpsButton.trailingAnchor.constraint(equalTo: cityTextField.leadingAnchor, constant: -10),
            gpsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configureCityTextField(){
        view.addSubview(cityTextField)
        cityTextField.delegate = self
        
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            cityTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushCityVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}


extension SearchVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushCityVC()
        return true
    }
    
    
}


extension SearchVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            lon         = location.coordinate.longitude
            lat         = location.coordinate.latitude
            isLocationReceived = true
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


