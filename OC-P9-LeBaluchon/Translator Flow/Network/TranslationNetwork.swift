// TranslationNetwork.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import Foundation


protocol TranslationNetworkType {
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, CurrencyResponse?) -> Void)
}

final class TranslationNetwork: TranslationNetworkType {
   
    
    static var shared = TranslationNetwork()
    
    private init() {}
    
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Bool, CurrencyResponse?) -> Void) {
        
    }
    
}
