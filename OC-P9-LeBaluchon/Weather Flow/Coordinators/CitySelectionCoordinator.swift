// CitySelectionCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var viewControllers: [UIViewController] = []
    
    weak var parentCoordinator: WeatherCoordinator?
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CitySelectionCoordinator {
    func start() {
        let viewController = CitySelectionViewController()
        let network = WeatherNetwork()
        viewController.coordinator = self
		let viewModel = WeatherViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.present(UINavigationController(rootViewController: viewController), animated: true)
    }

    func update(chosenCity: String) {
        parentCoordinator?.update(chosenCity: chosenCity)
    }
    
    func update(latitude: String, longitude: String) {
        parentCoordinator?.update(latitude: latitude, longitude: longitude)
    }
    func showErrorAlert(errorMessage: String) {
        guard let viewController = viewControllers.first as? CitySelectionViewController else {
            return
        }
        let alertView = UIAlertController(title: "Something went wrong", message: errorMessage , preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController.present(alertView, animated: true, completion: nil)
    }
	
	func vanishLoadingView() {
		parentCoordinator?.vanishLoadingView()
	}
	
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
	
	//MARK: Finishes
	func didFinishSelecting() {
		parentCoordinator?.childDidFinish(self)
	}
}
