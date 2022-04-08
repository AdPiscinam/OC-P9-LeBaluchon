// XCTestCase.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import XCTest

extension XCTestCase {
    // MARK: - Helper Methods

    func loadStub(name: String, extensionType: String) -> Data {
        // Obtain Reference to Bundle
           let bundle = Bundle(for: type(of: self))

           // Ask Bundle for URL of Stub
           let url = bundle.url(forResource: name, withExtension: extensionType)

           // Use URL to Create Data Object
           return try! Data(contentsOf: url!)
    }
}
