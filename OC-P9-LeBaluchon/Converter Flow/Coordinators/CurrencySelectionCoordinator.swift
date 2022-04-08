// CurrencySelectionCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class CurrencySelectionCoordinator: Coordinator {
   
    var navigationController: UINavigationController
    weak var parentCoordinator: ConverterCoordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CurrencySelectionCoordinator {
    
    func start() {
        let viewController = CurrencySelectionViewController()
        viewController.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.present(viewController, animated: true)
    }
}
