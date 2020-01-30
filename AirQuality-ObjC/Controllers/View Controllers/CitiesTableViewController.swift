//
//  CitiesTableViewController.swift
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = state,
            let country = country
            else { return }
        DSCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            DispatchQueue.main.async {
                if let cities = cities {
                    self.cities = cities
                }
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        cell.textLabel?.text = cities[indexPath.row]

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"
        {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? CityDetailViewController else { return }
            
            destinationVC.city = cities[indexPath.row]
            destinationVC.state = state
            destinationVC.country = country
            print(country)
        }
    }
    
    
}
