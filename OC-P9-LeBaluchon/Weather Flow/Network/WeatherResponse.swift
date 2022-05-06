// WeatherResponse.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import Foundation

// MARK: - CityWeatherResponse
struct WeatherResponse: Codable, Equatable {
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        var bool = false
        if lhs.weather == rhs.weather && lhs.name == rhs.name && lhs.main == rhs.main {
            bool = true
        }
        print(bool)

        return bool
    }
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

// MARK: - Main
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

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
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
