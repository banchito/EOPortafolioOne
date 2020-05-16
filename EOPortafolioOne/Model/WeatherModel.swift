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
    let description     : String
    let cityName        : String
    let cityId          : Double
    let temperature     : Double
    let feels           : Double
    let min             : Double
    let max             : Double
    let sunrise         : Date
    let sunset          : Date
    let timezone        : Date
    
    var temperatureString: String{
        return String(format: "%.0f" ,temperature)
    }
    
    var feelsString: String{
        return String(format: "%.0f" ,feels)
    }
    
    var minString: String{
        return String(format: "%.0f" ,min)
    }
    
    var maxString: String{
        return String(format: "%.0f", max)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return sfSymbols.cloudBolt.rawValue
        case 300...321:
            return sfSymbols.cloudDrizzle.rawValue
        case 500...504:
            return  sfSymbols.cloudHeavyrain.rawValue 
        case 511:
            return  sfSymbols.cloudSleet.rawValue
        case 520...531:
            return sfSymbols.cloudRain.rawValue
        case 600...622:
            return sfSymbols.cloudSnow.rawValue
        case 701...781:
            return sfSymbols.cloudFog.rawValue
        case 800:
            return sfSymbols.sunMax.rawValue
        case 801:
            return sfSymbols.cloudSun.rawValue
        case 802:
            return sfSymbols.cloud.rawValue
        case 803:
            return sfSymbols.smoke.rawValue
        case 804:
            return sfSymbols.cloudBolt.rawValue
        default:
            return sfSymbols.cloud.rawValue 
        }
    }
}
