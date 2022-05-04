// WeatherViewModel.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

final class WeatherViewModel {
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
    
    var subjectLabelTextUpdater: ((String) -> Void)?
   
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Weather")
        modalTitleText?("Settings")
        nyCityNameUpdater?("New York")
        nyDescriptionUpdater?("Description")
        nyTemperatureUpdater?("99°C")
        cityNameUpdater?("Paris")
        cityDescriptionUpdater?("Description")
        cityTemperatureUpdater?("99°C")
        subjectLabelTextUpdater?("Enter a City")
    }
    
    //MARK: Computed Properties
    
    private var cityImageViewGifName = "tornado" {
        didSet {
            cityImageViewGifNameUpdater?(cityImageViewGifName)
        }
    }
    
    private var nyImageViewGifName = "tornado" {
        didSet {
            nyImageViewGifNameUpdater?(nyImageViewGifName )
        }
    }
    
    func getCityWeather(city: String) {
        network.getWeather(city: city) {   [self] result in
            switch result {
            case .success(let response):
                cityNameUpdater?(response.name)
                cityTemperatureUpdater?("\(String(response.main.temp))°C")
                cityDescriptionUpdater?(response.weather[0].weatherDescription.capitalizingFirstLetter())
                setIconFrom(response: response, id: response.weather[0].id, imageViewGifName: &cityImageViewGifName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNyCityWeather() {
        network.getWeather(city: "New York") { [self] result in
            switch result {
            case .success(let response):
                nyCityNameUpdater?(response.name)
                nyTemperatureUpdater?("\(String(response.main.temp))°C")
                nyDescriptionUpdater?(response.weather[0].weatherDescription.capitalizingFirstLetter())
                setIconFrom(response: response, id: response.weather[0].id, imageViewGifName: &nyImageViewGifName)
            case .failure(let error):
                print(error.localizedDescription)
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
            imageViewGifName =  "mostlyCloudyNight"
        } else {
            imageViewGifName =  "partlySunny"
        }
        case 803...804: imageViewGifName = "cloudy"
        default: imageViewGifName =  "hurricane"
        }
    }
}
