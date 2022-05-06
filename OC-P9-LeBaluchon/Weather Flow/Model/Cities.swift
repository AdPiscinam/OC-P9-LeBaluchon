//
//  Cities.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 06/05/2022.
//

import Foundation

struct Cities: Decodable {
    
    let country: String
    let name: String
    let lat: String
    let lng: String
    
    
    static func translationFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: CitySelectionViewController.self)
        let url = bundle.url(forResource: "cities", withExtension: "json")!
        return try Data(contentsOf: url)
    }
    
    static func parseJSON(cityName: String) -> Bool {
        var bool = false
        let cities = try! translationFromJSON(fileName: "cities")
        do {
            let  result = try JSONDecoder().decode([Cities].self, from: cities)
            
            for (_, city) in result.enumerated() {
                if cityName == city.name {
                    bool = true
                }
            }
        } catch _ {
            return false
        }
        return bool
    }
    
    static func parseJSON() -> [Cities] {
        let cities = try! translationFromJSON(fileName: "cities")
        var parsedCities = [Cities]()
        do {
            let  result = try JSONDecoder().decode([Cities].self, from: cities)
            parsedCities = result
            return parsedCities
        } catch _ {
            print("error in parsing Cities")
        }
        return parsedCities
    }
}
