// String+Capitalization.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 26/04/2022
// 

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
