//
//  WeatherManager.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/4/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    static let shared   = NetworkManager()
    init(){}
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0ac83c5b6ba194a4fdb81d25ef69dc27&units=metric"
    
    
    func getWeatherByCity(for city: String, completed: @escaping (Result<WeatherModel, BoltError>) -> Void) {
        
        let endPoint = "\(baseURL)&q=\(city)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidCityName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data  else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(WeatherData.self, from: data)
                
                let id          = decodedData.weather[0].id
                let description = decodedData.weather[0].description
                let name        = decodedData.name
                let temp        = decodedData.main.temp
                let feels       = decodedData.main.feels_like
                let min         = decodedData.main.temp_min
                let max         = decodedData.main.temp_max
                let sunrise     = decodedData.sys.sunrise
                let sunset      = decodedData.sys.sunset
                let timezone    = decodedData.timezone
                
                let weather = WeatherModel(
                    conditionId     : id,
                    description     : description,
                    cityName        : name,
                    temperature     : temp,
                    feels           : feels,
                    min             : min,
                    max             : max,
                    sunrise         : sunrise,
                    sunset          : sunset,
                    timezone        : timezone
                )
                completed(.success(weather))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getWeatherBylocation(latitude: CLLocationDegrees,
                              longitude: CLLocationDegrees,
                              completed: @escaping (Result<WeatherModel, BoltError>) -> Void ){
        
        let endPoint = "\(baseURL)&lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidCoordinates))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder                     = JSONDecoder()
                let decodedData                 = try decoder.decode(WeatherData.self, from: data)
                decoder.dateDecodingStrategy    = .secondsSince1970
                
                let id          = decodedData.weather[0].id
                let description = decodedData.weather[0].description
                let name        = decodedData.name
                let temp        = decodedData.main.temp
                let feels       = decodedData.main.feels_like
                let min         = decodedData.main.temp_min
                let max         = decodedData.main.temp_max
                let sunrise     = decodedData.sys.sunrise
                let sunset      = decodedData.sys.sunset
                let timezone    = decodedData.timezone
                
                let weather = WeatherModel(
                    conditionId     : id,
                    description     : description,
                    cityName        : name,
                    temperature     : temp,
                    feels           : feels,
                    min             : min,
                    max             : max,
                    sunrise         : sunrise,
                    sunset          : sunset,
                    timezone        : timezone
                    )
                
                completed(.success(weather))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}

