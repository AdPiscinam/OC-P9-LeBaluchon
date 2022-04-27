// TranslatorFieldCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

class TranslatorFieldCoordinator: Coordinator {

    var navigationController: UINavigationController
    weak var parentCoordinator: TranslatorCoordinator?
    var childCoordinators: [Coordinator] = []
    var viewControllers: [UIViewController] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension TranslatorFieldCoordinator {
    
    func start() {
        let viewController = TranslatorFieldViewController()
        
        viewController.coordinator = self
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }

 
//    
//    func update(chosenCity: String) {
//        guard let viewController = navigationController.viewControllers.first as? WeatherViewController else {
//            return
//        }
//         viewController.updateChosenCity(name: chosenCity)
//    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
