// UIViewController+Alert.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 28/04/2022
// 

import UIKit

extension UIViewController: ShowAlert {
    func displayAlert() {
            let alertAction1 = UIAlertAction(title: "Ok", style: .default) {
                _ in
            }
            let alertAction2 = UIAlertAction(title: "Cancel", style: .destructive) {
                _ in
            }
            self.displayAlert(with: "Alert", message: "Sample Message", type: .alert, actions: [alertAction1, alertAction2])
    }
}

