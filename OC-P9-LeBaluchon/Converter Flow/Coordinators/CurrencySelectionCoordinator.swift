// CurrencySelectionCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class CurrencySelectionCoordinator: Coordinator {

    var navigationController: UINavigationController
    weak var parentCoordinator: ConverterCoordinator?
    var childCoordinators: [Coordinator] = []
    var viewControllers: [UIViewController] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CurrencySelectionCoordinator {
    
    func start() {
        let viewController = CurrencySelectionViewController()
        
        viewController.coordinator = self
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    func update(base: String, destination: String) {
        guard let viewController = navigationController.viewControllers.first as? ConverterViewController else {
            return
        }
        viewController.updateCurrenciesNames(base: base, destination: destination)
    }
    
    func update(response: ConversionResponse) {
        guard let viewController = navigationController.viewControllers.first as? ConverterViewController else {
            return
        }
        viewController.updateCurrencyResponse(response: response)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
