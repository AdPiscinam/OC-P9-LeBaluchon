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
    
    var resultAmountUpdater: ((String) -> Void)?
    var dateUpdater: ((String) -> Void)?
    var rateUpdater: ((String) -> Void)?
    var destinationUpdater: ((String) -> Void)?
    var baseUpdater: ((String) -> Void)?
        
    var amount = "0" {
        didSet {
            resultAmountUpdater?(amount)
        }
    }
    
    var doubledAmount: Double = 0

    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Converter")
        modalTitleText?("Currency")
        
        baseUpdater?("EUR")
        destinationUpdater?("USD")
        resultAmountUpdater?("0")
        
   //     dateUpdater?(getCurrentTime())
   //     getConversion(baseCode: "EUR", destinationCode: "USD")
        populateData()
    }
    
    func getConversion(baseCode: String, destinationCode: String) {
        //TODO: Uncomment me
        dateUpdater?(getCurrentTime())
        network.getData(baseCode: baseCode, destinationCode: destinationCode) { [self] result in
            switch result {
            case .success(let response):
                baseUpdater?(baseCode)
                destinationUpdater?(destinationCode)
                guard let rate = response?.rates[destinationCode]?.rate else {
                    return
                }
               
                rateUpdater?("1 \(baseCode) = \(rate) \(destinationCode)")
                
                guard let doubledRate = Double(rate) else {
                    return
                }
                
                let result = doubledRate * doubledAmount
                amount = String(result)
                resultAmountUpdater?(amount)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCurrentTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let dateString = df.string(from: date)
        return dateString
    }
  
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
