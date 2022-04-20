// WeatherViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit
import ImageIO

class WeatherViewController: UIViewController {
    weak var coordinator: WeatherCoordinator?
    
    let nyWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nyCityName: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nyDescription: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nyTemperature: UILabel = {
        let label = UILabel()
        label.text = "21°C"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityDescription: UILabel = {
        let label = UILabel()
        label.text = "Cloudy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperature: UILabel = {
        let label = UILabel()
        label.text = "9°C"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        title = "Weather"
        view.addSubview(nyWeatherImageView)
        view.addSubview(nyCityName)
        view.addSubview(nyDescription)
        view.addSubview(nyTemperature)
        view.addSubview(weatherImageView)
        view.addSubview(cityName)
        view.addSubview(cityDescription)
        view.addSubview(temperature)
        let logoutBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(settings))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        nyWeatherImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nyWeatherImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nyWeatherImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nyWeatherImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nyWeatherImageView.loadGif(name: "sunny")
        
        nyCityName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nyCityName.topAnchor.constraint(equalTo: nyWeatherImageView.bottomAnchor).isActive = true
        nyDescription.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nyDescription.topAnchor.constraint(equalTo: nyCityName.bottomAnchor).isActive = true
        
        nyTemperature.centerYAnchor.constraint(equalTo: nyWeatherImageView.centerYAnchor).isActive = true
        nyTemperature.trailingAnchor.constraint(equalTo: nyWeatherImageView.leadingAnchor, constant: -16).isActive = true
        nyTemperature.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        weatherImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 16).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImageView.loadGif(name: "rain")
        
        cityName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityName.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor).isActive = true
        cityDescription.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityDescription.topAnchor.constraint(equalTo: cityName.bottomAnchor).isActive = true
        
        temperature.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor).isActive = true
        temperature.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -16).isActive = true
        temperature.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
    }
    
    @objc func settings() {
        WeatherNetwork.shared.getWeather(city: "New York") { [self] (success, response) in
            if success, let response = response {
                nyCityName.text = response.name
                nyTemperature.text = String(response.main.temp)
                nyDescription.text = response.weather[0].weatherDescription.capitalizingFirstLetter()
                
                if response.weather[0].weatherDescription == "ciel dégagé" {
                    nyWeatherImageView.loadGif(name: "sunny")
                }
                print(response)
            }
        }
        
        
        
    //    coordinator?.startCitySelection()
    }
    
    func updateChosenCity(name: String) {
        cityName.text = name
      
        print("updating")
    }
    
}



extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
