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
    var onErrorHandling : ((String) -> Void)?
    
    var englishTextUpdater: ((String) -> Void)?
    var frenchTextUpdater: ((String) -> Void)?
    
    var textToTranslateUpdater: ((String) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Translator")
        modalTitleText?("Enter text")
        englishTextUpdater?("English")
        frenchTextUpdater?("Français")
        textToTranslateUpdater?("Tap to enter your text...")
    }
    
    func getTranslation(text: String) {
        network.getData(text: text) { [self] result in
            switch result {
            case .success(let response):
                englishTextUpdater?(response.data.translations[0].translatedText)
            case .failure(let error):
                self.onErrorHandling?(error.localizedDescription)
            }
        }
    }
}
