// OC_P9_LeBaluchonTests.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 19/04/2022
// 

import XCTest
@testable import OC_P9_LeBaluchon

//IMPORTANT: To test the Converter View Model, we commented the viewModel.viewDidLoad() method present in the ConverterVC viewDidLoad(), so that we could start with a 0% test coverage for this file

//class ConverterViewModelTests: XCTestCase {
//    
//    var sut: ConverterViewModel!
//    fileprivate var service : MockConversionNetwork!
//
//    override func setUpWithError() throws {
//        self.service = MockConversionNetwork()
//        self.sut = ConverterViewModel(network: service)
//    }
//    
//    override func tearDownWithError() throws {
//        self.sut = nil
//        self.service = nil
//    }
//    
//    func testGivenAConverterViewModel_WhenViewDidLoad_ThenTitleIsCorrectlyReturned() {
//        let expectation = self.expectation(description: "Title is not Correct")
//        let expectedTitle: String = "Converter"
//        sut.titleText = { title in
//            XCTAssertEqual(title, expectedTitle)
//            expectation.fulfill()
//        }
//        sut.viewDidLoad()
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//    
//    func testGivenAConverterViewModel_WhenViewDidLoad_ThenBaseIsCorrectlyReturned() {
//        let expectation = self.expectation(description: "Base is not Correct")
//        let expectedBase: String = "EUR"
//        
//        sut.baseUpdater = { base in
//            XCTAssertEqual(base, expectedBase)
//            expectation.fulfill()
//        }
//        sut.viewDidLoad()
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//    
//    func testGivenAConverterViewModel_WhenViewDidLoad_ThenDateIsCorrectlyReturned() {
//        let expectation = self.expectation(description: "Date is not Correct")
//        let expectedDate: String = sut.getCurrentTime()
//        
//        sut.dateUpdater = { date in
//            XCTAssertEqual(date, expectedDate)
//            expectation.fulfill()
//        }
//        
//        sut.getConversion(baseCode: "EUR", destinationCode: "USD")
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//    
//    func testGivenAConverterViewModel_WhenViewDidLoad_ThenDateIsCorrectlyReturne() {
//        let expectation = self.expectation(description: "Rate is not Correct")
//        let expectedAmount = "0"
//        
//        sut.resultAmountUpdater = { amount in
//            XCTAssertEqual(amount, expectedAmount)
//            expectation.fulfill()
//        }
//        sut.viewDidLoad()
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//    
//}
//
//fileprivate class MockConversionNetwork: ConversionNetworkType {
//    
    var currency: CurrencyResponse?
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Result<CurrencyResponse?, Error>) -> Void) {
        if let currency = currency {
            callback(Result.success(currency))
        } else {
            print("currency get error")
        }
    }
//}
