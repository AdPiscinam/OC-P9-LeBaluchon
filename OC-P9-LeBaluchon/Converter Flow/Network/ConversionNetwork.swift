// ConversionApi.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

protocol ConversionNetworkType {
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, CurrencyResponse?) -> Void)
}

final class ConversionNetwork: ConversionNetworkType {
    
    static var shared = ConversionNetwork()
    
    private init() {}
    
    var apiAdresse = "https://api.getgeoapi.com/v2/currency/convert?"
    var apiKey = "api_key="
    var keyValue = ""
    var from = "&from="
    var baseCode = "EUR"
    var to =  "&to="
    var destinationCode = "DZD"
    var amount = "&amount="
    var amountValue = "1"
    var format = "&format=json"
    var rate = 0.0
    
    private func constructApiCall(baseCode: String, destinationCode: String) -> String {
        apiAdresse + apiKey + keyValue + from + baseCode + to + destinationCode + amount + amountValue
    }
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, CurrencyResponse?) -> Void) {
        let url = constructApiCall(baseCode: baseCode, destinationCode: destinationCode)
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {  data, response, error in
           
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    //FIXME: Manage Errors with Alert
                    print("data error")
                    return
                }
                // we have data
                var result: CurrencyResponse?
                do {
                    
                    result = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                } catch  {
                    //FIXME: Manage Errors with Alert
                    print("data error2")
                }
                guard let json = result else {
                    //FIXME: Manage Errors with Alert
                    print("data error3")
                    return
                }
                callback(true, json)
                print(json)
            }
        }).resume()
    }
}
