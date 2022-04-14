// ConversionApi.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

final class ConversionService {
    
    static var shared = ConversionService()
    
    private init() {}
    
    var apiAdresse = "http://data.fixer.io/api/latest"
    var base = "?base="
    var baseCode = "EUR"
    var symbols =  "&symbols="
    var destinationCode = ""
    var accessKey = "&access_key=67ce629b8a4032fddf94a4b7b20fbe3d"
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
                    print(error!)
                    return
                }
                
                callback(true, json)
                self.rate = json.rates[destinationCode]!
               
            }
        }).resume()
        print(self.rate)
        print("hello")
    }
}
