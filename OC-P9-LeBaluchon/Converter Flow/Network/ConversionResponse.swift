// ConversionResponse.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 14/04/2022
// 

import Foundation

struct ConversionResponse: Codable {
    let success: Bool
    let timestamp: TimeInterval
    let base, date: String
    let rates: [String: Double]
}
