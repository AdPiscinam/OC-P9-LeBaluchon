// OC_P9_LeBaluchonTests.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import XCTest
@testable import OC_P9_LeBaluchon

class OC_P9_LeBaluchonTests: XCTestCase {
    
    var sut: ConverterViewModel!
    override func setUpWithError() throws {
        sut = ConverterViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDate() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-dd-yyyy HH:mm"
        let someDate = sut.stringedDate

        if dateFormatterGet.date(from: someDate) != nil {
            XCTAssertEqual(sut.stringedDate, "O3-08-2022 13:23")
        } else {
            print("h")
        }
        
    }
}
