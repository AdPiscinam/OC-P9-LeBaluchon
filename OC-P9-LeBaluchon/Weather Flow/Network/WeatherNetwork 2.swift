// WeatherNetwork.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

final class WeatherNetwork: WeatherNetworkType {
    var weatherResponse: WeatherResponse?
    
    private let session: URLSession
    
    init() {
        session = URLSession.init(configuration: .default)
    }
    
    let apiAdress = "https://api.openweathermap.org/data/2.5/weather?"
    var cityString = "q="
    var cityName = "New York"
    var latString = "lat="
    var latitude = "40.712784"
    var longString = "&lon="
    var longitude = "-74.005941"
    var accessKey = "&appid=404728b6e3ea5ba52b603ac5142c0d28"
    var remainingKeys = "&units=metric&lang=fr"
    private var task: URLSessionDataTask?
    
    func constructNameApiCall(cityName: String) -> String {
        apiAdress + cityString + cityName + accessKey + remainingKeys
    }
    
    func constructGeoApiCall(latitude: String, longitude: String) -> String {
        apiAdress + latString + latitude + longString + longitude + accessKey + remainingKeys
    }
    
    func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let stringURL = constructNameApiCall(cityName: city)
        
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let strigedUrl = URL(string: url) else { return }
        
        task = session.dataTask(with: strigedUrl, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 || response.statusCode == 404 else {
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
    
    func getWeather(latitude: String, longitude: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let stringURL = constructGeoApiCall(latitude: latitude, longitude: longitude)
        
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let strigedUrl = URL(string: url) else { return }
        
        task = session.dataTask(with: strigedUrl, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 || response.statusCode == 404 else {
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
