//
//  WeatherResponseTests.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import XCTest
@testable import OC_P9_LeBaluchon

class WeatherResponseTests: XCTestCase, DecodableTestCase { // 2
    
    var sut: WeatherResponse! // 3
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        try! weatherGivenSUTFromJSON() // 4
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil // 5
        try super.tearDownWithError()
    }
    
   //  MARK: - Type Tests
    func testConformsToDecodable() { // 6
        XCTAssertTrue((sut as Any) is Decodable) // cast silences a warning
    }
    
    func testConformsToEquatable() { // 7
        XCTAssertEqual(sut, sut) // requires Equatable conformance
    }
    
    func testDecodableSetsDocs() { // 8
        XCTAssertNotNil(sut.weather)
        XCTAssertEqual(sut.weather.count, 1)
    }
}
