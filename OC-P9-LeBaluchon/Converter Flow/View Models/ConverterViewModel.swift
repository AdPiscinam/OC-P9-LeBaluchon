// ConverterViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

protocol ConverterViewControllerDelegate: AnyObject {
    func catalogScreenDidSelectDetail(with title: String)
}

protocol ViewModel {}

final class ConverterViewModel: ViewModel {
    
    //MARK: Private Properties
    private weak var delegate: ConverterViewControllerDelegate?
    
    // MARK: - Initializer
    
    init(delegate: ConverterViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    
    var resultUpdater: ((String) -> Void)?
    var dateUpdater: ((String) -> Void)?
    var rateUpdater: ((String) -> Void)?
    
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        titleText?("Converter")
        
        
        resultUpdater?("0")
        dateUpdater?(getCurrentTime())
        rateUpdater?(currencyRate)
        
      /*  ConversionNetwork.shared.getData(baseCode: "EUR", destinationCode: "USD") { [self] (success, response) in
            if success, let response = response {
                print(success)
                print(response)
               
                rateUpdater?("1 Eur = \(String(response.rates["USD"]!))")
                
            }
           
        }*/
    }
    
    
    
    func getCurrentTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        return dateString
    }
   
    // Updaters
//    private let dateFormatter = DateFormatter()
//    // Properties
//    var resultOfConversion = "0" {
//        didSet {
//            resultUpdater?(resultOfConversion)
//        }
//    }
//
//    var date = "yyyy-MM-dd" {
//        didSet {
//            dateUpdater?(stringedDate)
//        }
//    }
//
    var currencyRate = "String" {
        didSet {
            rateUpdater?("1 Eur = \(currencyRate)$ ")
        }
    }
//
//    var stringedDate: String {
//        // Configure Date Formatter
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        return dateFormatter.string(from: .now)
//    }
    
}
