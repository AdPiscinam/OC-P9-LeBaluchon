// ConversionApi.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

final class ConversionNetwork {
    
    static var shared = ConversionNetwork()
    
    private init() {}
    
    var apiAdresse = "http://data.fixer.io/api/latest"
    var base = "?base="
    var baseCode = "EUR"
    var symbols =  "&symbols="
    var destinationCode = ""
    var accessKey = "&access_key=c88bc1a6702b2e1c1687e5301fbb50ba"
    var rate = 0.0
    
    func constructApiCall(baseCode: String, destinationCode: String) -> String {
        apiAdresse + base + baseCode + symbols + destinationCode + accessKey
    }
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, ConversionResponse?) -> Void) {
        let url = constructApiCall(baseCode: baseCode, destinationCode: destinationCode)
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self] data, response, error in
            DispatchQueue.main.async { [self] in
                guard let data = data , error == nil else {
                    //FIXME: Manage Errors with Alert
                    print(error!)
                    return
                }
                
                // we have data
                var result: ConversionResponse?
                do {
                    result = try JSONDecoder().decode(ConversionResponse.self, from: data)
                } catch  {
                    //FIXME: Manage Errors with Alert
                }
                guard let json = result else {
                    //FIXME: Manage Errors with Alert
                 //   print(error!)
                    return
                }
                callback(true, json)
                self.rate = json.rates[destinationCode]!
               
            }
        }).resume()
    }
}
