// ConverterCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class ConverterCoordinator: NSObject, Coordinator {
   
    var navigationController: UINavigationController
    var viewControllers: [UIViewController] = []
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ConverterCoordinator {
    
    func start() {
        let viewController = ConverterViewController()
        let network = ConversionNetwork.shared
        let tab = UITabBarItem(title: "Converter", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(systemName: "dollarsign.circle.fill"))
        viewController.tabBarItem = tab
        viewController.coordinator = self
        let viewModel = ConverterViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startCurrencySelection() {
        let child = CurrencySelectionCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func updateCurrenciesNames(base: String, destination: String) {
        guard let viewController = navigationController.viewControllers.first as? ConverterViewController else {
            return
        }
        viewController.updateCurrenciesNames(base: base, destination: destination)
    }

    //MARK: Finishes
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
//
//extension ConverterCoordinator: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//
//        if let currencySelectionCoordinator = fromViewController as? CurrencySelectionViewController {
//            childDidFinish(currencySelectionCoordinator.coordinator)
//            print("converter Finished")
//        }
//    }
//}
