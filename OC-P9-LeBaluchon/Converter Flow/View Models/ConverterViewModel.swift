// ConverterViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

final class ConverterViewModel {
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    
    var resultUpdater: ((String) -> Void)?
    var dateUpdater: ((String) -> Void)?
    var rateUpdater: ((String) -> Void)?
    var destinationUpdater: ((String) -> Void)?
    var baseUpdater: ((String) -> Void)?
    
    private var title = "Converter" {
        didSet {
            titleText?(title)
        }
    }
    
    private var currencyRate = "Rate" {
         didSet {
             rateUpdater?("1 Eur = \(currencyRate)$ ")
         }
     }
    
    private var result = "0" {
        didSet {
            resultUpdater?(result)
        }
    }
    
    private var destionationCode = "USD" {
        didSet {
            destinationUpdater?(destionationCode)
        }
    }
    
    private var baseCode = "EUR" {
        didSet {
            baseUpdater?(baseCode)
        }
    }
    
    private var date = "Date" {
        didSet{
            dateUpdater?(date)
        }
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?(title)
        resultUpdater?(result)
      //  dateUpdater?(getCurrentTime())
     //   rateUpdater?(getConversion())
        destinationUpdater?(destionationCode)
        baseUpdater?(baseCode)
    }

    func getCurrentTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        return dateString
    }
    
    func getConversion() -> String {
        //TODO: Uncomment me
        ConversionNetwork.shared.getData(baseCode: "EUR", destinationCode: "USD") { [self] (success, response) in
            if success, let response = response {
                currencyRate = "\(String(response.rates["USD"]!))"
            
            }
           
        }
        return currencyRate
    }
}
