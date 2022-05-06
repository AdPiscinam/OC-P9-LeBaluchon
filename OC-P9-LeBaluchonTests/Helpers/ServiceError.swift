//
//  ServiceError.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation

enum ServiceError: Swift.Error {
    case undefined
    case translationError
    case conversionError
    case noDataReceived
    case sourceLanguageIsEnglish
    var localizedDescription: String {
        switch self {
        case .undefined:
            return "Source language has not been detected"
        case .translationError:
            return "An error occured please try again"
        case .conversionError:
            return "An error occured please try again"
        case .noDataReceived:
            return "An error occured please try again"
        case .sourceLanguageIsEnglish:
            return ""
        }
    }
}
