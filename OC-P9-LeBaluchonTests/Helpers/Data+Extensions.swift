//
//   Data+Extensions.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation

import XCTest

extension Data {
    public static func currencyFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "FakeCurrencyData", withExtension: "json")!
        return try Data(contentsOf: url)
    }
    
    public static func weatherFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "NewYorkWeatherData", withExtension: "json")!
        return try Data(contentsOf: url)
    }
    
    public static func translationFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "FakeTranslateData", withExtension: "json")!
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass {}

