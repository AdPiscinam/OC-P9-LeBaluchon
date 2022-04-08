// WeatherCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class WeatherCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension WeatherCoordinator {
    func start() {
    }
}
