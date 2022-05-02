// CitySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    weak var coordinator: CitySelectionCoordinator?
    var viewModel: WeatherViewModel!
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityName: UITextField = {
        let field = UITextField()
        field.backgroundColor = .darkGray
        field.textAlignment = .center
        field.textColor = .systemBackground
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
        view.addSubview(label)
        view.addSubview(cityName)
        view.isOpaque = false
        let okBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        cityName.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -16).isActive = true
        cityName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
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
