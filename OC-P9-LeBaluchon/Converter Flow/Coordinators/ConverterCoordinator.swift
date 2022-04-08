// ConverterCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class ConverterCoordinator: Coordinator {
   
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ConverterCoordinator {
    
    func start() {
        let viewController = ConverterViewController()
        let tab = UITabBarItem(title: "Converter", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(systemName: "dollarsign.circle.fill"))
        viewController.tabBarItem = tab
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
