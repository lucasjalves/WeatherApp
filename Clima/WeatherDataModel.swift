//
//  WeatherDataModel.swift
//  WeatherApp
//
//

import UIKit
import SwiftyJSON
class WeatherDataModel {

    
    var temperatura: Int = 0
    var condition: Int = 0
    var city: String = ""
    var icone: String = ""
    var cidade: String = ""
    var estado: String = ""
    var pais: String = ""
    var img: String = ""
    init(){
        
    }

    convenience init(json: JSON){
        self.init()
        cidade = json["name"].string!
        pais = json["sys"]["country"].string!
        temperatura = Int(json["main"]["temp"].double! - 273.13)
        condition = json["weather"][0]["id"].int!
        img = updateWeatherIcon(condition: condition)
    }
  
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }

    }
}
