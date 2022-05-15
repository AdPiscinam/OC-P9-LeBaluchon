// MainTabBarController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class MainTabBarController: UITabBarController {
    let appCoordinator = AppCoordinator(navigationController: UINavigationController())
    
    let converterCoordinator = ConverterCoordinator(navigationController: UINavigationController())
    let weatherCoordinator = WeatherCoordinator(navigationController: UINavigationController())
    let translatorCoordinator = TranslatorCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        converterCoordinator.start()
        weatherCoordinator.start()
        translatorCoordinator.start()
        viewControllers = [converterCoordinator.navigationController, weatherCoordinator.navigationController, translatorCoordinator.navigationController]
    }
}
