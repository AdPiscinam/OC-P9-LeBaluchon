// WeatherViewModelTests.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 28/04/2022
// 

import XCTest
@testable import OC_P9_LeBaluchon

class WeatherViewModelTests: XCTestCase {
    
    
    var sut: WeatherViewModel!
    
//    override func setUpWithError() throws {
//        //TODO:
//        let mock = MockWeatherNetwork(response: )
//        sut = WeatherViewModel(network: mock)
//    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGivenAWeatherViewModel_WhenViewDidLoad_ThenTitleIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Title is not Correct")
        let expectedTitle: String = "Weather"
        sut.titleText = { title in
            XCTAssertEqual(title, expectedTitle)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAWeatherViewModel_WhenViewDidLoad_ThenNYNameIsCorrectlyReturned() {
        let expectation = self.expectation(description: "NY City Name is not Correct")
        let expectedName: String = "New York"
        sut.nyCityNameUpdater = { name in
            XCTAssertEqual(name, expectedName)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAWeatherViewModel_WhenViewDidLoad_ThenNYDescriptionIsCorrectlyReturned() {
        let expectation = self.expectation(description: "NY City Description is not Correct")
        let expectedName: String = "Description"
        sut.nyDescriptionUpdater = { description in
            XCTAssertEqual(description, expectedName)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAWeatherViewModel_WhenViewDidLoad_ThenNYTemperatureIsCorrectlyReturned() {
        let expectation = self.expectation(description: "NY City Temperature is not Correct")
        let expectedName: String = "99°C"
        sut.nyTemperatureUpdater = { temperature in
            XCTAssertEqual(temperature, expectedName)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
//    func testGivenAViewModel_WhenACityIsResearched_ThenViewModelIsUpdatedCorrectly() {
//        let mock = MockWeatherNetwork(response: )
//        mock.cityName = "Paris"
//        let expectation = self.expectation(description: "City Network not working")
//        let expectedName = "Paris"
//        sut.cityNameUpdater = { name in
//            XCTAssertEqual(name, expectedName)
//            expectation.fulfill()
//        }
//        sut.getCityWeather(city: "Paris")
//
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//
//    func testGivenAViewModel_WhenNewYorkIsResearched_ThenViewModelIsUpdatedCorrectly() {
//        let mock = MockWeatherNetwork(response: .init(onGetWeather: .failure()))
//        mock.cityName = "New York"
//        let expectation = self.expectation(description: "NY Network not working")
//        let expectedName = "New York"
//        sut.nyCityNameUpdater = { name in
//            XCTAssertEqual(name, expectedName)
//            expectation.fulfill()
//        }
//        sut.getNyCityWeather()
//
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
}

fileprivate final class MockWeatherNetwork: WeatherNetworkType {
    
    struct Response {
        let onGetWeather: Result<WeatherResponse, Error>
    }
    
    let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void) {
        callback(response.onGetWeather)
    }
        
}


