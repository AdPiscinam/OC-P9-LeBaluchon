//
//  MockConversionNetwork.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation
@testable import OC_P9_LeBaluchon

class MockConversionNetwork: ConversionNetworkType {
    var baseCurrency: String
    var baseCurrencyName: String
    var amount: String
    var updatedDate: String
    var rates: [String: CurrencyResponse.Rate]
    var status: String
    
    var currencyResponse: CurrencyResponse?
    var apiCallCounter = 0
    
    init(baseCurrency: String, baseCurrencyName: String, amount: String, updatedDate: String, rates: [String: CurrencyResponse.Rate], status: String) {
        self.baseCurrency = baseCurrency
        self.baseCurrencyName = baseCurrencyName
        self.amount = amount
        self.updatedDate = updatedDate
        self.rates = rates
        self.status = status
        self.currencyResponse = CurrencyResponse(baseCurrencyCode: baseCurrency, baseCurrencyName: baseCurrencyName, amount: amount, updatedDate: updatedDate, rates: rates, status: status)
    }
    
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Result<CurrencyResponse?, Error>) -> Void) {
        
        self.apiCallCounter += 1
        
        guard let conversionResponse = self.currencyResponse else {
            callback(.failure(ServiceError.conversionError))
            return
        }
        callback(.success(conversionResponse))
        
    }
}


