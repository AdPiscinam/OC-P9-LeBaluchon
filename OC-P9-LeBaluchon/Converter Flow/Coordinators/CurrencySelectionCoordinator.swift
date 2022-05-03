// CurrencySelectionCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class CurrencySelectionCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewControllers: [UIViewController] = []
    
    weak var parentCoordinator: ConverterCoordinator?
    var childCoordinators: [Coordinator] = []
  
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CurrencySelectionCoordinator {
    func start() {
        let viewController = CurrencySelectionViewController()
        let network = ConversionNetwork()
        viewController.coordinator = self
        let viewModel = ConverterViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    func update(base: String, destination: String) {
        parentCoordinator?.updateCurrenciesNames(base: base, destination: destination)
    }
    
    func fetchData(){
        parentCoordinator?.fetchData()
    }

    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func didFinishSelecting() {
        parentCoordinator?.childDidFinish(self)
    }
}
