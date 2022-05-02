// CitySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    weak var coordinator: CitySelectionCoordinator?
    var viewModel: WeatherViewModel!
    
    let cityName: UITextField = {
        let field = UITextField()
        field.backgroundColor = .darkGray
        field.textAlignment = .center
        field.textColor = .systemBackground
        field.clearButtonMode = .whileEditing
        field.clearsOnBeginEditing = true
        field.layer.cornerRadius = 10
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func apply() {
        guard let name = cityName.text else {
            //TODO: add alert to provide a name
            return
        }
        coordinator?.update(chosenCity: name)
        coordinator?.dismiss()
    }
}

//MARK: User Interface Setup
extension CitySelectionViewController {
    private func setupUI() {
        view.backgroundColor = .customLightBrown
        navigationController?.navigationBar.tintColor = UIColor.customOrange

        view.addSubview(cityName)
        view.isOpaque = false
        
        let okBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
        
        cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        cityName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        cityName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

//MARK: View Model Binding
extension CitySelectionViewController {
    func bind(to: WeatherViewModel) {
        viewModel.subjectLabelTextUpdater = { [weak self] text in
            self?.title = text
        }
    }
}
