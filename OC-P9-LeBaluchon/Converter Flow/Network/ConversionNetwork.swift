// ConversionApi.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

protocol ConversionNetworkType {
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, ConversionResponse?) -> Void)
}


final class ConversionNetwork: ConversionNetworkType {
    
    static var shared = ConversionNetwork()
    
    private init() {}
    
    var apiAdresse = "https://free.currconv.com/api/v7/"
    var base = "convert?q="
    var baseCode = "USD"
    var symbols =  "_"
    var destinationCode = "EUR"
    var accessKey = "&compact=ultra&apiKey=92d20273b92e9fbce9b5"
    var rate = 0.0
    
    private func constructApiCall(baseCode: String, destinationCode: String) -> String {
        apiAdresse + base + baseCode + symbols + destinationCode + accessKey
    }
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, ConversionResponse?) -> Void) {
        let url = constructApiCall(baseCode: baseCode, destinationCode: destinationCode)
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self] data, response, error in
            
            DispatchQueue.main.async { [self] in
                guard let data = data , error == nil else {
                    //FIXME: Manage Errors with Alert
                
                    return
                }
            
                // we have data
                var result: ConversionResponse?
                do {
                    result = try JSONDecoder().decode(ConversionResponse.self, from: data)
                    print(result?.chosenConversion)
                } catch  {
                    //FIXME: Manage Errors with Alert
                }
                print(result?.chosenConversion)
                guard let json = result else {
                    //FIXME: Manage Errors with Alert
                     
                    return
                }
                callback(true, json)
                self.rate = json.chosenConversion
                print(self.rate)
               
            }
        }).resume()
    }
//    
//    func getDataFromEuroToDollar(callback: @escaping (Bool, ConversionResponse?) -> Void) {
//        let url = constructApiCall(baseCode: "EUR", destinationCode: "USD")
//       
//        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self] data, response, error in
//           
//            DispatchQueue.main.async { [self] in
//                guard let data = data , error == nil else {
//                    //FIXME: Manage Errors with Alert
//                    return
//                }
//                
//                // we have data
//                var result: ConversionResponse?
//                do {
//                    result = try JSONDecoder().decode(ConversionResponse.self, from: data)
//                } catch  {
//                    //FIXME: Manage Errors with Alert
//                }
//                guard let json = result else {
//                    //FIXME: Manage Errors with Alert
//            
//                    return
//                }
//                callback(true, json)
//                self.rate = json.chosenConversion
//            }
//        }).resume()
//    }
}
