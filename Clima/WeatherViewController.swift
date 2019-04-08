//
//  ViewController.swift
//  WeatherApp
//
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "02632ae7724149a9b1be2e2259b74816"
    var clima: WeatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
      
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url: String, params: [String : String]){
        Alamofire.request(url, method: .get, parameters: params)
            .responseJSON{
                response in
                if(response.result.isSuccess){
                    let weatherJSON : JSON = JSON(response.result.value!)
                    self.updateWeatherData(json: weatherJSON)
                }else{
                    self.cityLabel.text = "Problema de conexao"
                }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON){
        if (json["cod"].int == 200){
            clima = WeatherDataModel(json: json)
            temperatureLabel.text = "\(clima.temperatura)°"
            cityLabel.text = "\(clima.cidade), \(clima.pais)"
            weatherIcon.image = UIImage(named: clima.img)
        }else{
            cityLabel.text = "Falha ao conculstar informacoes"
        }
        
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location =
            locations[locations.count - 1]
        
        if(location.horizontalAccuracy > 0){
            locationManager.stopUpdatingLocation();
        }
        
        let latitude =
            String(location.coordinate.latitude)
        
        let longitude =
            String(location.coordinate.longitude)
        
        let params : [String : String] =
            ["lat": latitude, "lon": longitude, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, params: params)
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Erro ao buscar informacoes do GPS"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


