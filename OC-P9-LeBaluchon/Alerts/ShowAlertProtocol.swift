// ShowAlertProtocol.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 28/04/2022
// 

import UIKit

protocol ShowAlert {
    func displayAlert(with title: String, message: String, type: UIAlertController.Style?,  actions: [UIAlertAction]?)
}

extension ShowAlert where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, type: UIAlertController.Style? = .alert,  actions: [UIAlertAction]? = nil) {
        
        guard presentedViewController == nil else { return }
        
        let alertController  = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
        actions?.forEach({ action in
            alertController.addAction(action)
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
