//
//  WeatherAPITests.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import XCTest
import Foundation
@testable import OC_P9_LeBaluchon

class WeatherAPINetworkTests: XCTestCase {
    
    func testGetWeatherForParisShouldGetParisWeather() {
        let expectation = self.expectation(description: "Incorrect data")
        
        let weather = Weather(id: 800, main: "Clear", weatherDescription: "ciel dégagé", icon: "01n")
        let wind = Wind(speed: 4.12, deg: 290)
        let clouds = Clouds(all: 1)
        let main = Main(temp: -5.41, feelsLike: -11.62, tempMin: -6.11, tempMax: -5, pressure: 1023, humidity: 50)
        let sys = Sys(type: 1, id: 5141, country: "US", sunrise: 1611490354, sunset: 1611525811)
        let coord = Coord(lon: -74.006, lat: 40.7143)
        
        let weatherServiceMock = MockWeatherNetwork(coord: coord, weather: [weather], base: "stations", main: main, visibility: 10000, wind: wind, clouds: clouds, dt: 1611489707, sys: sys, timezone: -18000, id: 5128581, name: "New York", cod: 200)
       
        var response: WeatherResponse?

        weatherServiceMock.getWeather(city: "New York") { result in
            switch result {
            case .success(let result): print("succ")
                response = result
            case .failure(_):
                print("wrong")
                return
            }
            expectation.fulfill()
        }
        
      
        //Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.name, "New York")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

 
