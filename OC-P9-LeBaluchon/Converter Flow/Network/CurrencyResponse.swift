// ConversionResponse.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 14/04/2022
// 

import Foundation

struct CurrencyResponse: Decodable {
    let baseCurrencyCode: String
    let baseCurrencyName: String
    let amount: String
    let updatedDate: String
    let rates: [String: Rate]
    let status: String
    
    struct Rate: Decodable {
        let currencyName: String
        let rate: String
        let rateForAmount: String
        
        enum CodingKeys: String, CodingKey {
            case rate
            case currencyName = "currency_name"
            case rateForAmount = "rate_for_amount"
        }
    }
    enum CodingKeys: String, CodingKey{
        case baseCurrencyCode = "base_currency_code"
        case baseCurrencyName = "base_currency_name"
        case amount, rates, status
        case updatedDate = "updated_date"
      }
}
