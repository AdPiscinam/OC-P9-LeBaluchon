//
//  WeatherNetworkType.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 10/05/2022.
//

import Foundation

protocol WeatherNetworkType {
	func getWeather(city: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void)
	func getWeather(latitude: String, longitude: String, callback: @escaping (Result<WeatherResponse, Error>) -> Void)
}
