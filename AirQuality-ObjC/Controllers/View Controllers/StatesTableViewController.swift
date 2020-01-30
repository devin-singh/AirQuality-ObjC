//
//  StatesTableViewController.swift
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {
    
    var country: String?
    var states: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = country else { return }
        DSCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            DispatchQueue.main.async {
                if let states = states {
                    self.states = states
                }
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        cell.textLabel?.text = states[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? CitiesTableViewController else { return }
            let stateToSend = states[indexPath.row]
            destinationVC.state = stateToSend
            destinationVC.country = country
        }
    }
    
}

