//
//  MockTranslationNetwork.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation
@testable import OC_P9_LeBaluchon

class MockTranslationNetwork  {
    let data: TranslationDataClass
    let translations: [TranslationDataClass]
    let translatedText: String
    let detectedSourceLanguage: String
    var translateResponse: TranslateResponse?
    
    init(data: TranslationDataClass, translations: [TranslationDataClass], translatedText: String, detectedSourceLanguage: String) {
        self.data = data
        self.translations = translations
        self.translatedText = translatedText
        self.detectedSourceLanguage = detectedSourceLanguage
        self.translateResponse = TranslateResponse(data: data)
    }
}

extension MockTranslationNetwork: TranslationNetworkType {
	func getData(text: String, callback: @escaping (Result<TranslateResponse, Error>) -> Void) {
		guard self.translateResponse != nil else {
			callback(.failure(ServiceError.noDataReceived))
			return
		}

		let decoder = JSONDecoder()
		do {
			let data = try Data.translationFromJSON(fileName: "FakeTranslateData")
			let translation = try decoder.decode(TranslateResponse.self, from: data)
			callback(.success(translation))
		} catch _ {
			callback(.failure(ServiceError.translationError))
		}
	}
}
