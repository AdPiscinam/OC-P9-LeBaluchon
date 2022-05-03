// WeatherNetwork.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

protocol WeatherNetworkType {
    func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void)
}

final class WeatherNetwork: WeatherNetworkType {
    var weatherResponse: WeatherResponse?
    
    private let session: URLSession
    
    init() {
        session = URLSession.init(configuration: .default)
    }
    
    let apiAdress = "https://api.openweathermap.org/data/2.5/weather?q="
    var cityName = "New York"
    var accessKey = "&appid=404728b6e3ea5ba52b603ac5142c0d28"
    var remainingKeys = "&units=metric&lang=fr"
    private var task: URLSessionDataTask?
    
    func constructApiCall(cityName: String) -> String {
        apiAdress + cityName + accessKey + remainingKeys
    }
    
    func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let stringURL = constructApiCall(cityName: city)
        
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let strigedUrl = URL(string: url) else { return }
        
        task = session.dataTask(with: strigedUrl, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 404 else {
                    return
                }
                
                var result: WeatherResponse?
                
                do {
                    result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                } catch let error {
                    callback(.failure(error))
                }
                guard let json = result else {
                    return
                }
                callback(.success(json))
            }
        })
        task?.resume()
    }
}
