//
//  TranslateTextResponseTranslation.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 03/05/2022.
//

import Foundation

// MARK: - TranlationResponse
struct TranslateTextResponseList: Codable {
    let list: [TranslateTextResponseTranslation]
}

struct TranslateTextResponseTranslation: Codable {
    let data: TranslationDataClass
}

// MARK: - DataClass
struct TranslationDataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
