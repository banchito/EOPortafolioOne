//
//  BoltError.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/8/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation

enum BoltError: String, Error {
    
    case invalidCityName    = "City name created an invalid request. Please try again"
    case invalidCoordinates = "Coordinates created an invalid request. Please try again"
    case unableToComplete   = "Unable to complete your request. Please check you internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data received from the server was invalid. Please try again"
    
    case unvableTofavorite  = "There was an error favoriting this city, please try again."
    case alreadyInFavorites = "You've already favorited this city"
    
 
}
