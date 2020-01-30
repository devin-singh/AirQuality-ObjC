//
//  CountriesTableViewController.swift
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    var countries: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DSCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                DispatchQueue.main.async {
                    self.countries = countries
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row];
        
        return cell
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStateVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? StatesTableViewController else { return }
            let countryToSend = countries[indexPath.row]
            destinationVC.country = countryToSend
        }
     }
}
