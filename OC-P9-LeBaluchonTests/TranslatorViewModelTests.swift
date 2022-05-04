//
//  TranslatorViewModelTests.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 04/05/2022.
//

import XCTest
@testable import OC_P9_LeBaluchon

class TranslatorViewModelTests: XCTestCase {
    var sut: TranslatorViewModel!
    fileprivate var service : TranslationNetwork!
    
    override func setUpWithError() throws {
        self.service = TranslationNetwork()
        self.sut = TranslatorViewModel(network: service)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.service = nil
    }
    
    
    func testGivenAConverterViewModel_WhenViewDidLoad_ThenTitleIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Title is not Correct")
        let expectedTitle: String = "Translator"
        sut.titleText = { title in
            XCTAssertEqual(title, expectedTitle)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testGivenAConverterViewModel_WhenTranslationIsCalled_ThenTranslationIsCorrectlyReturned() {
        let expectation = self.expectation(description: "Translation is not Correct")
        
        let expectedText: String = "Hello"
      
        sut.englishTextUpdater = { text in
            XCTAssertEqual(text, expectedText)
            expectation.fulfill()
        }
        sut.getTranslation(text: "Bonjour")
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
