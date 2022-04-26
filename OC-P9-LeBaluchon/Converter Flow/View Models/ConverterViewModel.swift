// ConverterViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

final class ConverterViewModel {
    
    private let network: ConversionNetworkType
    
    init(network: ConversionNetworkType) {
        self.network = network
    }
    
    var ratesCityCode: [String: String] = [:]
    var currenciesArray: [String] = []
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var modalTitleText: ((String) -> Void)?
    
    var resultUpdater: ((String) -> Void)?
    var dateUpdater: ((String) -> Void)?
    var rateUpdater: ((String) -> Void)?
    var destinationUpdater: ((String) -> Void)?
    var baseUpdater: ((String) -> Void)?
    
    private var currencyRate = "Rate" {
         didSet {
             rateUpdater?("1 Eur = \(currencyRate)$ ")
         }
     }
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Converter")
        modalTitleText?("Currency")
        resultUpdater?("0")
        dateUpdater?(getCurrentTime())
        rateUpdater?(getConversion(baseCode: "EUR", destinationCode: "USD"))
        destinationUpdater?("USD")
        baseUpdater?("EUR")
        populateData()
    }

    func getCurrentTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm:ss"            //"yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        return dateString
    }
    
    func getConversion(baseCode: String, destinationCode: String) -> String {
        //TODO: Uncomment me
        network.getData(baseCode: "EUR", destinationCode: "USD") { [self] (success, response) in
            
            if success, let response = response {
                currencyRate = "\(String(response.chosenConversion))"
                print(currencyRate)
            }
        }
        return currencyRate
    }
    

    
    // CHANTIER
    
    func populateData() {
        for (code, _) in Currency.jsonData {
            ratesCityCode[code] = Currency.jsonData[code]?.name
        }
        self.currenciesArray = createArrayFormDictionnary(dict: ratesCityCode)
        
    }
    
    func createArrayFormDictionnary(dict: [String: String]) -> [String]{
       var array: [String] = []
       for (key, value) in dict {
           array.append(key + " - \(value)")
       }
       
       return array.sorted()
   }
}
