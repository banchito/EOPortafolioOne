//
//  FavoritesListVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 4/29/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    
    let tableView               = UITableView()
    var favoritesCities: [City] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getfavorites()
        
    }
    
    
    func configureViewController() {
         view.backgroundColor         = .systemBackground
         title                        = "Favorites Cities"
         navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.rowHeight  = 60
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    

    func getfavorites()  {
        
        PersistanceManager.retreiveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let favorites):
                if favorites.isEmpty{
                    self.presentBoltAlertOnMainThread(title: "No cities added yet.", message: "Add a city after your search.", buttonTitle: "Ok")
                } else {
                    self.favoritesCities = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentBoltAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell     = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        
        let favorite = favoritesCities[indexPath.row]
        
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite    = favoritesCities[indexPath.row]
        let destVC      = CityVC()
        destVC.city     = favorite.name.replacingOccurrences(of: " ", with: "+")
        destVC.title    = favorite.name
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = favoritesCities[indexPath.row]
        favoritesCities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left )
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            self.presentBoltAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
