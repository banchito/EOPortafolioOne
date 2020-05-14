//
//  WeatherData.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/5/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation
struct WeatherData: Codable {
    let name        : String
    let timezone    : Date
    let main        : Main
    let sys         : Sys
    let weather     : [Weather]
}

struct Main: Codable {
    let temp        : Double
    let feels_like  : Double
    let temp_min    : Double
    let temp_max    : Double
}

struct Weather: Codable {
    let description : String
    let id          : Int
}

struct Sys: Codable {
    let sunrise     : Date
    let sunset      : Date
}


