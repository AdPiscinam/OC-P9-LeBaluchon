// WeatherViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit
import ImageIO

class WeatherViewController: UIViewController {
   
    weak var coordinator: WeatherCoordinator?
    var viewModel: WeatherViewModel!
    
    let nyWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nyCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nyTemperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .ultraLight)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityTemperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .ultraLight)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getNYWeather()
        getWeather(city: "Paris")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to: WeatherViewModel) {
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        // NY
        viewModel.nyCityNameUpdater = { [weak self] name in
            self?.nyCityName.text = name
        }
        viewModel.nyDescriptionUpdater = { [weak self] description in
            self?.nyDescription.text = description
            
        }
        viewModel.nyTemperatureUpdater = { [weak self] temperature in
            self?.nyTemperature.text = temperature
        }
        
        viewModel.cityNameUpdater = { [weak self] name in
            self?.cityName.text = name
        }
        
        viewModel.cityDescriptionUpdater = { [weak self] description in
            self?.cityDescription.text = description
        }
        
        viewModel.cityTemperatureUpdater = { [weak self] temperature in
            self?.cityTemperature.text = temperature
        }
        
        viewModel.cityImageViewGifNameUpdater = { [weak self] name in
            self?.cityWeatherImageView.loadGif(name: name)
        }
    }
    
    @objc func settings() {
        coordinator?.startCitySelection()
    }
    
    func getNYWeather() {
        viewModel.getNyCityWeather()
    }
    
    func getWeather(city: String) {
        viewModel.getCityWeather(city: city)
    }
    
    func updateChosenCity(name: String) {
        getWeather(city: name)
    }
}

extension WeatherViewController{
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(nyWeatherImageView)
        view.addSubview(nyCityName)
        view.addSubview(nyDescription)
        view.addSubview(nyTemperature)
        view.addSubview(cityWeatherImageView)
        view.addSubview(cityName)
        view.addSubview(cityDescription)
        view.addSubview(cityTemperature)
        
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
        
        cityWeatherImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityWeatherImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 16).isActive = true
        cityWeatherImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cityWeatherImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cityWeatherImageView.loadGif(name: "rain")
        
        cityName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityName.topAnchor.constraint(equalTo: cityWeatherImageView.bottomAnchor).isActive = true
        cityDescription.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityDescription.topAnchor.constraint(equalTo: cityName.bottomAnchor).isActive = true
        
        cityTemperature.centerYAnchor.constraint(equalTo: cityWeatherImageView.centerYAnchor).isActive = true
        cityTemperature.trailingAnchor.constraint(equalTo: cityWeatherImageView.leadingAnchor, constant: -16).isActive = true
        cityTemperature.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
    }
}
