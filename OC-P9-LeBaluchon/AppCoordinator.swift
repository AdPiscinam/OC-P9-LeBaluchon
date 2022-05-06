// AppCoordinator.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    func start()
}


final class AppCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator {
    func start() {
        let child = ConverterCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
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
