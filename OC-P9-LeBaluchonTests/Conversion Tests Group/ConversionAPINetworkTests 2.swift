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
	var baseCurrecy: String!
	var baseCurrencyName: String!
	var amount: String!
	var updatedData: String!
	var rates: [String : CurrencyResponse.Rate]!
	var status: String!
	var conversionMock: MockConversionNetwork!
	var sut: ConverterViewModel!
	
	override func setUpWithError() throws {
		let rate = CurrencyResponse.Rate(currencyName: "Algerian dinar", rate: "154.2781", rateForAmount: "154.2781")
		conversionMock = MockConversionNetwork(baseCurrency: "EUR", baseCurrencyName: "Euro", amount: "1.0000", updatedDate: "2022-05-05", rates: ["DZD" : rate], status: "success")
		sut = ConverterViewModel(network: conversionMock)
		
	}

	override func tearDownWithError() throws {
		conversionMock = nil
		sut = nil
	}
	
    func test_GivenOneEuro_WhenConvertToDinar_ResultIsCorrect() {
        
        let expectation = self.expectation(description: "Not Returned JSON")
        let expectedResult = CurrencyResponse.Rate(currencyName: "Algerian dinar", rate: "154.2781", rateForAmount: "154.2781")

		sut.rateUpdater = { amount in
			XCTAssertEqual(amount, "1 EUR = \(expectedResult.rateForAmount) DZD")
			expectation.fulfill()
		}

		sut.getConversion(baseCode: "EUR", destinationCode: "DZD")
       waitForExpectations(timeout: 1.0, handler: nil)
    }
}
