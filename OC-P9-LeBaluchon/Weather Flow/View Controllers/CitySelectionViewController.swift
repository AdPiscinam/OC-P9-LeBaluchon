// CitySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    var data: [Cities]? = nil
    let stuff = ["One", "Two", "Three"]
    var filteredData: [String]!
    
    weak var coordinator: CitySelectionCoordinator?
    var viewModel: WeatherViewModel!
    
    let cityNameSearchTextField: UISearchBar = {
        let field = UISearchBar()
        field.backgroundColor = .darkGray
        field.layer.cornerRadius = 10
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .yellow
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        resultTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "City")
        
        cityNameSearchTextField.delegate = self
        
        
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        data = Cities.parseJSON()
        filteredData = getCitiesNames()
    }
    
    @objc func apply() {
        guard let name = cityNameSearchTextField.text else {
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = getCitiesNames()
        resultTableView.reloadData()
        
        filteredData = searchText.isEmpty ? filteredData : filteredData.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        resultTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        guard let unwrappedCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let currentCell = unwrappedCell
        
        guard let unwrappedTextLabel = currentCell.textLabel, var unwrappedText = unwrappedTextLabel.text else {
            return
        }
      
        cityNameSearchTextField.text = deleteCountryFrom(name: &unwrappedText)
    }
    
    func deleteCountryFrom(name: inout String) -> String {
        name.removeLast()
        name.removeLast()
        name.removeLast()
        return name
    }
    
    
    func getCitiesNames() -> [String] {
        var names = [String]()
        guard let safeData = data else {
            return names
        }
        
        
        for city in safeData {
            let phrase = "\(city.name) \(city.country)"
            names.append(phrase)
        }
        return names
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
            self.cityNameSearchTextField.placeholder = cityToSearch
        }
        
        viewModel.searchedCityTextFieldUpdater = { text in
            self.cityNameSearchTextField.text = text
        }
    }
}

//MARK: User Interface Setup
extension CitySelectionViewController {
    private func setupUI() {
        view.backgroundColor = .customLightBrown
        navigationController?.navigationBar.tintColor = UIColor.customOrange
        
        view.addSubview(cityNameSearchTextField)
        view.addSubview(resultTableView)
        view.isOpaque = false
        
        let okBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        cityNameSearchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityNameSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        cityNameSearchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        cityNameSearchTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        resultTableView.topAnchor.constraint(equalTo: cityNameSearchTextField.bottomAnchor).isActive = true
        resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    
    static func parseJSON() -> [Cities] {
        let cities = try! translationFromJSON(fileName: "cities")
        var parsedCities = [Cities]()
        do {
            let  result = try JSONDecoder().decode([Cities].self, from: cities)
            parsedCities = result
            return parsedCities
        } catch _ {
            print("error in parsing Cities")
        }
        return parsedCities
    }
}

extension String {
  
}
