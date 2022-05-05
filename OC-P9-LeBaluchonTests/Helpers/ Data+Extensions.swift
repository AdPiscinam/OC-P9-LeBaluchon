//
//   Data+Extensions.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation

import XCTest

extension Data {
    public static func fromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "FakeCurrencyData", withExtension: "json")!
       // let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: "json"))
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass { }

