// TranslatorCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

final class TranslatorCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewControllers: [UIViewController] = []
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension TranslatorCoordinator {
    func start() {
        let viewController = TranslatorViewController()
        let network = TranslationNetwork()
        let tab = UITabBarItem(title: "Translator", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
        viewController.tabBarItem = tab
        viewController.coordinator = self
        let viewModel = TranslatorViewModel(network: network)
        viewController.viewModel = viewModel
        viewControllers.append(viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customOrange]

    }
    
    func startTranslatorField() {
        let child = TranslatorFieldCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func updateTranslation(text: String){
        guard let viewController = navigationController.viewControllers.first as? TranslatorViewController else {
            return
        }
        viewController.updateTranslation(text: text)
    }
    
    func showErrorAlert(errorMessage: String) {
        guard let viewController = navigationController.viewControllers.first as? ConverterViewController else {
            return
        }
        let alertView = UIAlertController(title: "Something went wrong", message: errorMessage , preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController.present(alertView, animated: true, completion: nil)
    }

    //MARK: - Finishes
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
