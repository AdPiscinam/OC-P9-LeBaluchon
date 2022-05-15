// WeatherResponse.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import Foundation

struct WeatherResponse: Codable, Equatable {
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
}

struct Main: Codable, Equatable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

//MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable, Equatable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

extension WeatherResponse {
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        var bool = false
        if lhs.weather == rhs.weather && lhs.name == rhs.name && lhs.main == rhs.main {
            bool = true
        }
        return bool
    }
}
