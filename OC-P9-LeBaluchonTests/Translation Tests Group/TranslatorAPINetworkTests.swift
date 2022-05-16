//
//  TranslatorAPINetworkTests.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 10/05/2022.
//

import XCTest
import Foundation
@testable import OC_P9_LeBaluchon

class TranslatorAPINetworkTests: XCTestCase {
	var data: TranslationDataClass!
	var translations: Translation!
	var translationMock: MockTranslationNetwork!
	var sut: TranslatorViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		translations = Translation(translatedText: "Hello", detectedSourceLanguage: "fr")
		data = TranslationDataClass(translations: [translations])
		translationMock = MockTranslationNetwork(data: data, translations: [data], translatedText: translations.translatedText, detectedSourceLanguage: translations.detectedSourceLanguage)
		sut = TranslatorViewModel(network: translationMock)
    }

    override func tearDownWithError() throws {
        data = nil
		translations = nil
		translationMock = nil
		sut = nil
    }

	func test_AFrenchEntry_WhenTranslationIsAsked_EnglishResponseIsCourrect() {
		let expectation = self.expectation(description: "Not Returned JSON")
		let expectedResult = TranslateResponse(data: data)

		sut.englishTextUpdater = { text in
			XCTAssertEqual(text, expectedResult.data.translations[0].translatedText)
			expectation.fulfill()
		}

		sut.getTranslation(text: "")
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func test_GivenViewModel_WhenViewDidLoad_ThenDestinationLabelDisplayIsCorrect() {
		let expectation = self.expectation(description: "View Did Load Error")
		let expectedResult = "Tap to translate"

		sut.foreignTextUpdater = { text in
			XCTAssertEqual(text, expectedResult)
			expectation.fulfill()
		}

		sut.viewDidLoad()
		waitForExpectations(timeout: 1.0, handler: nil)
	}
}
