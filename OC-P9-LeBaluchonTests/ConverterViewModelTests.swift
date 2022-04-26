// OC_P9_LeBaluchonTests.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 19/04/2022
// 

import XCTest
@testable import OC_P9_LeBaluchon

//IMPORTANT: To test the Converter View Model, we commented the viewModel.viewDidLoad() method present in the ConverterVC viewDidLoad(), so that we could start with a 0% test coverage for this file

class ConverterViewModelTests: XCTestCase {
    
    
    var sut: ConverterViewModel!
    
    
    override func setUpWithError() throws {
        sut = ConverterViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenTitleIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Title is not Correct")
        let expectedTitle: String = "Converter"
        sut.titleText = { title in
            XCTAssertEqual(title, expectedTitle)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
//    var destinationUpdater: ((String) -> Void)?
//    var baseUpdater: ((String) -> Void)?

    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenBaseIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Base is not Correct")
        let expectedBase: String = "EUR"
        sut.baseUpdater = { base in
            XCTAssertEqual(base, expectedBase)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenDateIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Date is not Correct")
       
        let expectedDate: String = sut.getCurrentTime()
        sut.dateUpdater = { date in
            XCTAssertEqual(date, expectedDate)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenRateIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Rate is not Correct")
       
        let expectedRate = sut.getConversion()
        sut.rateUpdater = { rate in
            XCTAssertEqual(rate, expectedRate)
            expectation.fulfill()
        }

        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    
    
}