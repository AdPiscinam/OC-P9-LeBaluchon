//
//  APIServiceTests.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import XCTest
import Foundation
@testable import OC_P9_LeBaluchon

class ConversionAPINetworkTests: XCTestCase {
    
    func testGetConvertionFor1DollarInEuroShouldGetConvertion() {
        
        let expectation = self.expectation(description: "Returned JSON")
        let rate = CurrencyResponse.Rate(currencyName: "Algerian dinar", rate: "154.2781", rateForAmount: "154.2781")
        let euroBasedMock = MockConversionNetwork(baseCurrency: "EUR", baseCurrencyName: "Euro", amount: "1.0000", updatedDate: "2022-05-05", rates: ["DZD" : rate], status: "success")
        
        var response: CurrencyResponse?
        
        euroBasedMock.getData(baseCode: "EUR", destinationCode: "DZD") { result in
            switch result {
            case .success(let result): response = result
            case .failure(_):
                return
            }
            expectation.fulfill()
        }
       
        XCTAssertEqual(response?.amount, "1.0000")
        XCTAssertEqual(response?.rates["DZD"], rate)
        XCTAssertEqual(response?.updatedDate, euroBasedMock.updatedDate)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

