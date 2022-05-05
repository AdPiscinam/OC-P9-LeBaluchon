//
//  DecodableTestCase.swift
//  OC-P9-LeBaluchonTests
//
//  Created by Walim Aloui on 05/05/2022.
//

import Foundation
import XCTest

protocol DecodableTestCase: AnyObject {
    associatedtype T: Decodable
    var sut: T! { get set }
}
extension DecodableTestCase {
    func givenSUTFromJSON(fileName: String = "\(T.self)") throws {
        let decoder = JSONDecoder()
        let data = try Data.fromJSON(fileName: fileName)
        sut = try decoder.decode(T.self, from: data)
    }
}
