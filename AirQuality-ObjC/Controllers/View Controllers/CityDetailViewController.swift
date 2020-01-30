//
//  CityDetailViewController.swift
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    // MARK: - Properties
    var country: String?
    var state: String?
    var city: String?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
            let state = state,
            let country = country
            else { return }
        
        DSCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            DispatchQueue.main.async {
                if let details = cityDetails {
                    self.updateViews(with: details)
                }
            }
        }
    }
    
    func updateViews(with details: DSCityAirQuality) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = details.city
            self.stateNameLabel.text = details.state
            self.countryNameLabel.text = details.country
            self.aqiLabel.text = "AQI: \(details.pollution.airQualityIndex)"
            self.windSpeedLabel.text = "Windspeed: \(details.weather.windSpeed)"
            self.temperatureLabel.text = "Temperature \(details.weather.temperature)"
            self.humidityLabel.text = "Humidity \(details.weather.humidity)"
        }
    }    
}
