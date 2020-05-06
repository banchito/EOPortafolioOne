//
//  WeatherModel.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/5/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation
struct WeatherModel {
    
    let conditionId     : Int
    let cityName        : String
    let temperature     : Double
    let feels           : Double
    let min             : Double
    let max             : Double
    
    
    var temperatureString: String{
        return String(format: "%.1f" ,temperature)
    }
    
    var  conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "clound.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
