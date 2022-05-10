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
	var cod: Int!
	var id: Int!
	var timezone: Int!
	var sys: Sys!
	var dt: Int!
	var clouds: Clouds!
	var wind: Wind!
	var visibility: Int!
	var main: Main!
	var base: String!
	var weather: [Weather]!
	var coord: Coord!
	var weatherMock: WeatherNetworkType!
	var sut: WeatherViewModel!
	
	override func setUpWithError() throws {
		cod = 200
		let name = "New York"
		id = 5128581
		timezone = -18000
		sys = Sys(type: 1, id: 5141, country: "US", sunrise: 1611490354, sunset: 1611525811)
		dt = 1611489707
		clouds = Clouds(all: 1)
		wind = Wind(speed: 4.12, deg: 290)
		visibility = 10000
		main = Main(temp: -5.41, feelsLike: -11.62, tempMin: -6.11, tempMax: -5, pressure: 1023, humidity: 50)
		base = "stations"
		weather = [Weather(id: 800, main: "Clear", weatherDescription: "Ciel dégagé", icon: "01n")]
		coord = Coord(lon: -74.006, lat: 40.7143)
		weatherMock = MockWeatherNetwork(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
		
		sut = WeatherViewModel(network: weatherMock)
	}
	
	override func tearDownWithError() throws {
		weatherMock = nil
		sut = nil
	}

	func testGivenWeatherLookedForWithName_WhenCallIsPerformed_ThenCityDescriptionIsUpdatedCorrectly() {
		let expectation = self.expectation(description: "Incorrect data")
		let expectedResult = WeatherResponse(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
		
		sut.cityDescriptionUpdater = { name in
			XCTAssertEqual(name, expectedResult.weather[0].weatherDescription)
			expectation.fulfill()
		}
		
		sut.getCityWeather(city: "")
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testGivenWeatherLookedForWithCoordinates_WhenCallIsPerformed_ThenCityDescriptionIsUpdatedAccordingly() {
		let expectation = self.expectation(description: "Incorrect data")
		let expectedResult = WeatherResponse(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
		
		sut.cityDescriptionUpdater = { name in
			XCTAssertEqual(name, expectedResult.weather[0].weatherDescription)
			expectation.fulfill()
		}
		
		sut.getCityWeather(latitude: "", longitude: "")
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testGivenNoCallIsMade_WhenViewLoads_ThenLabelsAreSetCorrectly() {
		let expectation = self.expectation(description: "Incorrect data")
		let expectedResult = "Description"
		
		sut.cityDescriptionUpdater = { name in
			XCTAssertEqual(name, expectedResult)
			expectation.fulfill()
		}
		
		sut.viewDidLoad()
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testGivenACityNameThatDoesNotExist_WhenEnteredForASearch_ThenMethodsReturnsFalse() {
		let existence = sut.cityExists(with: "POAZIEPAOEIPOAIE")
		XCTAssertEqual(existence, false)
	}
	
	func testGivenACityNameThatDoesNotExist_WhenEnteredForASearch_ThenMethodsReturnsTrue() {
		let existence = sut.cityExists(with: "Paris")
		XCTAssertEqual(existence, true)
	}
	
	func testGivenWeatherLookedForWithCoordinates_WhenCallIsPerformed_ThenCityDescriptionIsUpdatedAccordingly2() {
		let expectation = self.expectation(description: "Incorrect data")
		let expectedResult = WeatherResponse(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod)
		
		sut.nyTemperatureUpdater = { temperature in
			XCTAssertEqual(temperature, String("\(expectedResult.main.temp)°C"))
			expectation.fulfill()
		}
		
		sut.getNyCityWeather()
		waitForExpectations(timeout: 1.0, handler: nil)
	}
}
