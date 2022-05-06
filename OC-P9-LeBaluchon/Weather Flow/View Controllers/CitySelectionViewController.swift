// CitySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    weak var coordinator: CitySelectionCoordinator?
    var viewModel: WeatherViewModel!
    
    let cityNameTextField: UITextField = {
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
        guard let name = cityNameTextField.text else {
            return
        }
        if viewModel.cityExists(with: name) == true {
           coordinator?.update(chosenCity: name)
           coordinator?.dismiss()
        }
    }
    
    @objc func cancel() {
        coordinator?.dismiss()
    }
    
    func showMessage(errorMessage: String) {
        coordinator?.showErrorAlert(errorMessage: errorMessage)
    }
}

//MARK: View Model Binding
extension CitySelectionViewController {
    func bind(to: WeatherViewModel) {
        viewModel.subjectLabelTextUpdater = { [weak self] text in
            self?.title = text
        }
        viewModel.onErrorHandling = {  error in
            self.showMessage(errorMessage: error)
        }
        
        viewModel.searchedCityPlaceHolderUpdater = { cityToSearch in
            self.cityNameTextField.placeholder = cityToSearch
        }
        
        viewModel.searchedCityTextFieldUpdater = { text in
            self.cityNameTextField.text = text
        }
    }
}

//MARK: User Interface Setup
extension CitySelectionViewController {
    private func setupUI() {
        view.backgroundColor = .customLightBrown
        navigationController?.navigationBar.tintColor = UIColor.customOrange
        
        view.addSubview(cityNameTextField)
        view.isOpaque = false
        
        let okBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        cityNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        cityNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        cityNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

struct Cities: Decodable {
    
    let country: String
    let name: String
    let lat: String
    let lng: String
    
    
    static func translationFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: CitySelectionViewController.self)
        let url = bundle.url(forResource: "cities", withExtension: "json")!
        return try Data(contentsOf: url)
    }
    
    static func parseJSON(cityName: String) -> Bool {
        var bool = false
        let cities = try! translationFromJSON(fileName: "cities")
        do {
            let  result = try JSONDecoder().decode([Cities].self, from: cities)
            
            for (_, city) in result.enumerated() {
                if cityName == city.name {
                    bool = true
                }
            }
        } catch _ {
            return false
        }
        return bool
    }
}
