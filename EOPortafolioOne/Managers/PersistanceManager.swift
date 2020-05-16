//
//  PersistanceManager.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/14/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation

enum PersistanceActionType{
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: City, actionType: PersistanceActionType, completed: @escaping (BoltError?) -> Void){
        retreiveFavorites { result in
            switch result{
            case .success(var favorites):
                
                switch actionType {
                    
                case .add:
                    guard !favorites.contains(favorite) else { completed(.alreadyInFavorites)
                        return }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.cityId == favorite.cityId }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retreiveFavorites(completed: @escaping (Result<[City], BoltError>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([City].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unvableTofavorite))
        }
    }
    
    static func save(favorites: [City]) -> BoltError? {
        
        do{
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unvableTofavorite
        }
    }
}
