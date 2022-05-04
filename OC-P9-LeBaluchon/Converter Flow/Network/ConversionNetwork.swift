// ConversionApi.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import Foundation

protocol ConversionNetworkType {
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Result<CurrencyResponse?, Error>) -> Void)
}

final class ConversionNetwork: ConversionNetworkType {
    var weatherResponse: CurrencyResponse?
    
    private let session: URLSession
    private var task: URLSessionDataTask?
   
    init() {
        session = URLSession.init(configuration: .default)
    }
    
    var apiAdresse = "https://api.getgeoapi.com/v2/currency/convert?"
    var apiKey = "api_key="
    var keyValue = "f8513c87b89eb3b39235d47eec48f50fae8b31c7"
    var from = "&from="
    var baseCode = "EUR"
    var to =  "&to="
    var destinationCode = ""
    var amount = "&amount="
    var amountValue = "1"
    var format = "&format=json"
    var rate = 0.0
    
    private func constructApiCall(baseCode: String, destinationCode: String) -> String {
        apiAdresse + apiKey + keyValue + from + baseCode + to + destinationCode + amount + amountValue + format
    }
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Result<CurrencyResponse?, Error>) -> Void) {
        let stringURL = constructApiCall(baseCode: baseCode, destinationCode: destinationCode)
       
       task = session.dataTask(with: URL(string: stringURL)!, completionHandler: {  data, response, error in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                var result: CurrencyResponse?
                do {
                    result = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                } catch  {
                    //FIXME: Manage Errors with Alert
                    callback(.failure(error))
                }
                guard let json = result else {
                    return
                }
                callback(.success(json))
            }
        })
       task?.resume()
    }
}
