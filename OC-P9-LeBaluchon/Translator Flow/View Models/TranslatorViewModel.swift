// TranslatorViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import Foundation

class TranslatorViewModel {
    
    private let network: TranslationNetworkType
    
    init(network: TranslationNetworkType) {
        self.network = network
    }
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var modalTitleText: ((String) -> Void)?
    
    var englishTextUpdater: ((String) -> Void)?
    var frenchTextUpdater: ((String) -> Void)?
    
    var textToTranslateUpdater: ((String) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("TranslatorVM")
        modalTitleText?("Enter textVM")
        
        englishTextUpdater?("EnglishVM")
        frenchTextUpdater?("Tap to translateVM")
        
        textToTranslateUpdater?("Tap to enter your text...")
//        rateUpdater?(getConversion(baseCode: "EUR", destinationCode: "USD"))
//        destinationUpdater?("USD")
//        baseUpdater?("EUR")
//        populateData()
    }
}
