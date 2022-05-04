// WeatherViewModelTests.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 28/04/2022
// 

import XCTest
@testable import OC_P9_LeBaluchon

class WeatherViewModelTests: XCTestCase {
    
    
    var sut: WeatherViewModel!
    fileprivate var service : WeatherNetwork!
    
    override func setUpWithError() throws {
        self.service = WeatherNetwork()
        self.sut = WeatherViewModel(network: service)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.service = nil
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenTitleIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Title is not Correct")
        let expectedTitle: String = "Weather"
        sut.titleText = { title in
            XCTAssertEqual(title, expectedTitle)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenNewYorkCityIsCorrectlyReturned() {
        let expectation = self.expectation(description: "New York name is not Correct")
        let expectedTitle: String = "New York"
      
        sut.nyCityNameUpdater = { city in
            XCTAssertEqual(city, expectedTitle)
            expectation.fulfill()
        }
        sut.getNyCityWeather()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenCityIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Paris ame is not Correct")
        let expectedTitle: String = "Paris"
      
        sut.cityNameUpdater = { city in
            XCTAssertEqual(city, expectedTitle)
            expectation.fulfill()
        }
        sut.getCityWeather(city: "Paris")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
    

fileprivate final class MockWeatherNetwork: WeatherNetworkType {
    
    var weather: WeatherResponse?
    
    func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
    }
}

class FakeWeatherData {
    // MARK: - Data
    static var parisWeatherData: Data? {
        let bundle = Bundle(for: FakeWeatherData.self)
        let url = bundle.url(forResource: "NewYorkWeatherData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}



