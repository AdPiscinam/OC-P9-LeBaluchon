// WeatherCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class WeatherCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var viewControllers: [UIViewController] = []
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension WeatherCoordinator {
    func start() {
        let viewController = WeatherViewController()
        let network = WeatherNetwork()
        let tab = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun.rain"), selectedImage: UIImage(systemName: "cloud.sun.rain.fill"))
        viewController.tabBarItem = tab
        viewController.coordinator = self
        let viewModel = WeatherViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startCitySelection() {
        let child = CitySelectionCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func update(chosenCity: String) {
        guard let viewController = navigationController.viewControllers.first as? WeatherViewController else {
            return
        }
         viewController.getWeather(city: chosenCity)
    }
}
