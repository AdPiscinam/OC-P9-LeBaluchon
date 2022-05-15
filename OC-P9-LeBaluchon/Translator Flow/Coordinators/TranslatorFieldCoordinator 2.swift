// TranslatorFieldCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

final class TranslatorFieldCoordinator: Coordinator {
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
        let network = TranslationNetwork()
        viewController.coordinator = self
        let viewModel = TranslatorViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
        
    }
    
    func updateTranslation(text: String) {
        parentCoordinator?.updateTranslation(text: text)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
