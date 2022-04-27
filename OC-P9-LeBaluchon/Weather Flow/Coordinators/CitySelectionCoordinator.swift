// CitySelectionCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: WeatherCoordinator?
    var childCoordinators: [Coordinator] = []
    var viewControllers: [UIViewController] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CitySelectionCoordinator {
    
    func start() {
        let viewController = CitySelectionViewController()
        
        viewController.coordinator = self
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }

 
    func update(chosenCity: String) {
        parentCoordinator?.update(chosenCity: chosenCity)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
