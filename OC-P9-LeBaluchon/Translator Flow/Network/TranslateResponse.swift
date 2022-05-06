//
//  TranslateTextResponseTranslation.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 03/05/2022.
//

import Foundation

// MARK: - TranlationResponse
struct TranslateResponse: Codable, Equatable {
    
    static func == (lhs: TranslateResponse, rhs: TranslateResponse) -> Bool {
        var bool = false
        if lhs.data == rhs.data {
            bool = true
        }
        print(bool)

        return bool
    }
    
    let data: TranslationDataClass
}

// MARK: - DataClass
struct TranslationDataClass: Codable, Equatable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable, Equatable {
    let detectedSourceLanguage: String
    let translatedText: String
}
