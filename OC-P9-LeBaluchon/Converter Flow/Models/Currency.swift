// Currency.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

struct Currency {
    
    static let share = Currency()
    
    private init() {}
    
    static var currenciesData: Data? {
        let path = Bundle.main.path(forResource: "CurrenciesData", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try? Data(contentsOf: url)
    }
    
    let data = try! JSONDecoder().decode(CurrenciesData.self, from: currenciesData!)
}


// MARK: - CurrenciesDataValue
struct CurrenciesDataValue: Codable {
    let symbol, name, symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code, namePlural: String

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding, code
        case namePlural = "name_plural"
    }
}
// The key of this dictionnary is the currency code
typealias CurrenciesData = [String: CurrenciesDataValue]
