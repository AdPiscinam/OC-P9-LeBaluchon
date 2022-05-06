//
//  ConversionNetworkType.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation

protocol ConversionNetworkType {
    func getData(baseCode: String, destinationCode: String, callback: @escaping (Result<CurrencyResponse?, Error>) -> Void)
}
