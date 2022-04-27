// WeatherViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

class WeatherViewModel {
    
    private let network: WeatherNetworkType
    
    init(network: WeatherNetworkType) {
        self.network = network
    }
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var modalTitleText: ((String) -> Void)?
    
    var nyCityNameUpdater: ((String) -> Void)?
    var nyDescriptionUpdater: ((String) -> Void)?
    var nyTemperatureUpdater: ((String) -> Void)?
    
    var cityNameUpdater: ((String) -> Void)?
    var cityDescriptionUpdater: ((String) -> Void)?
    var cityTemperatureUpdater: ((String) -> Void)?
    
    var cityImageViewGifNameUpdater: ((String) -> Void)?
    var nyImageViewGifNameUpdater: ((String) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("WeatherVM")
        modalTitleText?("SettingsVM")
        
        nyCityNameUpdater?(nyCityName)
        nyDescriptionUpdater?(nyDescription)
        nyTemperatureUpdater?(nyTemperature)
        
        cityNameUpdater?(cityName)
        cityDescriptionUpdater?(cityDescription)
        cityTemperatureUpdater?(cityTemperature)
    }
    
    //MARK: Computed Properties
    private var nyCityName = "New York" {
        didSet {
            nyCityNameUpdater?(nyCityName)
        }
    }
    
    private var nyDescription = "Cloudy" {
        didSet {
            nyDescriptionUpdater?(nyDescription)
        }
    }
    
    private var nyTemperature = "99°C" {
        didSet {
            nyTemperatureUpdater?(nyTemperature)
        }
    }
    
    private var cityName = "City" {
        didSet {
            cityNameUpdater?(cityName)
        }
    }
    
    private var cityDescription = "Cloudy" {
        didSet {
            cityDescriptionUpdater?(cityDescription)
        }
    }
    
    private var cityTemperature = "99°CV" {
        didSet {
            cityTemperatureUpdater?(cityTemperature)
        }
    }
    
    private var cityImageViewGifName = "tornado" {
        didSet {
            cityImageViewGifNameUpdater?(cityImageViewGifName)
        }
    }
    
    private var nyImageViewGifName = "tornado" {
        didSet {
            nyImageViewGifNameUpdater?(nyImageViewGifName)
        }
    }
    
    func getCityWeather(city: String) {
        WeatherNetwork.shared.getWeather(city: city) { [self] (success, response) in
            if success, let response = response {
                cityName = response.name
                cityTemperature = "\(String(response.main.temp))°C"
                cityDescription = response.weather[0].weatherDescription.capitalizingFirstLetter()
                setIconFrom(response: response, id: response.weather[0].id, imageViewGifName: &cityImageViewGifName)
                
            }
        }
    }
    
    func getNyCityWeather() {
        WeatherNetwork.shared.getWeather(city: "New York") { [self] (success, response) in
            if success, let response = response {
                nyCityName = response.name
                nyTemperature = "\(String(response.main.temp))°C"
                nyDescription = response.weather[0].weatherDescription.capitalizingFirstLetter()
                setIconFrom(response: response, id: response.weather[0].id, imageViewGifName: &nyImageViewGifName)
                
            }
        }
    }
    
    func setIconFrom(response: WeatherResponse, id: Int, imageViewGifName: inout String) {
        switch id {
        case 200...232 : imageViewGifName = "storm"
        case 300...310:  if response.weather[0].icon.contains("n") {
            imageViewGifName = "drizzleNight"
        } else {
            imageViewGifName = "drizzleSunny"
        }
        case 311...321:  imageViewGifName = "drizzle"
        case 500...503:  if response.weather[0].icon.contains("n") {
            imageViewGifName = "rainNight"
        } else {
            imageViewGifName =  "rainSunny"
        }
        case 504:  imageViewGifName =  "rain"
        case 511...531:  if response.weather[0].icon.contains("n") {
            imageViewGifName = "rainNight"
        } else {
            imageViewGifName =  "rainSunny"
        }
        case 600...602: imageViewGifName =  "snowy"
        case 611...622: if response.weather[0].icon.contains("n") {
            imageViewGifName =  "snowyNight"
        } else {
            imageViewGifName =  "snowySunny"
        }
        case 701...762:  imageViewGifName =  "mist"
        case 771: imageViewGifName =  "windy"
        case 781: imageViewGifName = "tornado "
        case 800: if response.weather[0].icon.contains("n") {
            imageViewGifName =  "clearNight"
        } else {
            imageViewGifName = "sunny"
        }
        case 801: if response.weather[0].icon.contains("n") {
            imageViewGifName =  "partlyCloudyNight"
        } else {
            imageViewGifName =  "partlyCloudy"
        }
        case 802: if response.weather[0].icon.contains("n") {
            imageViewGifName =  "mostlylCloudyNight"
        } else {
            imageViewGifName =  "partlySunny"
        }
        case 803...804: imageViewGifName = "cloudy"
        default: imageViewGifName =  "hurricane"
        }
    }
    
}



