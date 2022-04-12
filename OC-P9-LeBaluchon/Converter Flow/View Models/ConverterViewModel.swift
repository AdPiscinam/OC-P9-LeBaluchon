// ConverterViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

final class ConverterViewModel {
    // Updaters
    var resultUpdater: ((String) -> Void)?
    var dateUpdater: ((String) -> Void)?
    var rateUpdater: ((String) -> Void)?
   
    private let dateFormatter = DateFormatter()
    // Properties
    var resultOfConversion = "0" {
        didSet {
            resultUpdater?(resultOfConversion)
        }
    }
    
    var date = "yyyy-MM-dd" {
        didSet {
            dateUpdater?(stringedDate)
        }
    }
    
    var currencyRate = "ring" {
        didSet {
            rateUpdater?(currencyRate)
        }
    }
    
    // ViewDidLoad
    func viewDidLoad() {
        resultOfConversion = "USD."
        date = "Date"
        currencyRate = "Rate"
    }
    
    var stringedDate: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: .now)
    }
    
}
