//
//  WeatherManager.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/4/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation
class NetworkManager {
    
    static let shared   = NetworkManager()
    init(){}
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0ac83c5b6ba194a4fdb81d25ef69dc27&units=metric"
    
   
    func getWeather(for cityName: String, completed: @escaping (WeatherData?, String?) -> Void) {
        
        let endPoint = "\(baseURL)&q=\(cityName)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "City name created an invalid request. Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check you internet connection")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                completed(nil, "Invalid response from the server. Please try again")
                return
            }
            
            guard let data = data  else{
                completed(nil, "The data received from the server was invalid. Please try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherData.self, from: data)
                completed(weather, nil )
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again")
            }
        }
        task.resume()
    }
    
    
}
 
