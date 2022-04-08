// TranslatorCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class TranslatorCoordinator: Coordinator {
   
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension TranslatorCoordinator {
    func start() {
        let viewController = TranslatorViewController()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
