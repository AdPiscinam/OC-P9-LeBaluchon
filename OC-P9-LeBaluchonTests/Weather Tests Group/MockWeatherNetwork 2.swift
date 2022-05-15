//
//  MockWeatherNetwork.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation
@testable import OC_P9_LeBaluchon

class MockWeatherNetwork {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int

    var weatherResponse: WeatherResponse?
    var apiCallCounter = 0

    init(coord: Coord, weather: [Weather], base: String, main: Main, visibility: Int, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
        self.weatherResponse = WeatherResponse(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
    }
}

extension MockWeatherNetwork: WeatherNetworkType {
	static var cityName: String?
	
	func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
		guard self.weatherResponse != nil else {
			callback(.failure(ServiceError.noDataReceived))
			return
		}
		
		let decoder = JSONDecoder()
		do {
			let data = try Data.weatherFromJSON(fileName: "NewYorkWeatherData")
			let weather = try decoder.decode(WeatherResponse.self, from: data)
			callback(.success(weather))
		} catch _ {
			callback(.failure(ServiceError.noDataReceived))
		}
	}

	func getWeather(latitude: String, longitude: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
		guard self.weatherResponse != nil else {
			callback(.failure(ServiceError.noDataReceived))
			return
		}
		
		let decoder = JSONDecoder()
		do {
			let data = try Data.weatherFromJSON(fileName: "NewYorkWeatherData")
			let weather = try decoder.decode(WeatherResponse.self, from: data)
			callback(.success(weather))
		} catch _ {
			callback(.failure(ServiceError.noDataReceived))
		}
	}
}



