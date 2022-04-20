// WeatherNetwork.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import Foundation

final class WeatherNetwork {
    
    var weatherResponse: WeatherResponse?
    static var shared = WeatherNetwork()
    private init() {}
    
    let apiAdress = "https://api.openweathermap.org/data/2.5/weather?q="
    var cityName = "New York"
    var accessKey = "&appid=404728b6e3ea5ba52b603ac5142c0d28"
    var remainingKeys = "&units=metric&lang=fr"
    
    var temperature: Double = 0
    
    func constructApiCall(cityName: String) -> String {
        apiAdress + cityName + accessKey + remainingKeys
    }
    
    func getWeather(city: String, callback: @escaping (Bool, WeatherResponse?) -> Void) {
        var url = constructApiCall(cityName: city)
        print(url)
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler:  { [self] data, response, error in
            
            DispatchQueue.main.async { [self] in
                guard let data = data , error == nil else {
                    //FIXME: Manage Errors with Alert
                    print(error!)
                    return
                }
                
                // we have data
                var result: WeatherResponse?
                do {
                    result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                } catch  {
                    //FIXME: Manage Errors with Alert
                }
                guard let json = result else {
                    //FIXME: Manage Errors with Alert
                    //   print(error!)
                    return
                }
                callback(true, json)
                self.temperature = json.main.temp
                print(self.temperature)
            }
        }).resume()
    }
    
    
    
}

