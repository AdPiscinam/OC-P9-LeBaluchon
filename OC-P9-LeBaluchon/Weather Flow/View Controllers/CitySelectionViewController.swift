// CitySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 20/04/2022
// 

import UIKit

class CitySelectionViewController: UIViewController {
	weak var coordinator: CitySelectionCoordinator?
	var viewModel: WeatherViewModel!
	
	var data: [Cities] = []
	var filteredData: [String]!
	var latitude = String()
	var longitude = String()
	var selectedCity = String()
	
	let cityNameSearchTextField: UISearchBar = {
		let field = UISearchBar()
		field.backgroundColor = .darkGray
		field.layer.cornerRadius = 10
		field.translatesAutoresizingMaskIntoConstraints = false
		return field
	}()
	
	let resultTableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .customBackground
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		coordinator?.vanishLoadingView()
		resultTableView.dataSource = self
		resultTableView.delegate = self
		resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "City")
		cityNameSearchTextField.delegate = self
		setupUI()
		bind(to: viewModel)
		viewModel.viewDidLoad()
		filteredData = getCitiesNames()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		coordinator?.didFinishSelecting()
		data = []
		filteredData = []
		latitude = String()
		longitude = String()
		selectedCity = String()
	}
	
	@objc func apply() {
		latitude = extractGeoCoordinates(from: &selectedCity).0
		longitude = extractGeoCoordinates(from: &selectedCity).1
		coordinator?.update(latitude: latitude, longitude: longitude)
		coordinator?.dismiss()
	}
	
	@objc func cancel() {
		coordinator?.dismiss()
	}
	
	func showMessage(errorMessage: String) {
		coordinator?.showErrorAlert(errorMessage: errorMessage)
	}
	
	//MARK: Helper Methods
	private func keepOnlyCity(name: inout String) -> String {
		var serparatedString = name.components(separatedBy: " ")
		serparatedString.removeLast()
		serparatedString.removeLast()
		serparatedString.removeLast()
		serparatedString.removeLast()
		serparatedString.removeLast()
		name = serparatedString.joined(separator: " ")
		return name
	}
	
	private func extractGeoCoordinates(from text: inout String) -> (String, String) {
		var separatedString = text.components(separatedBy: " ")
		let longitude = separatedString.last
		separatedString.removeLast()
		separatedString.removeLast()
		let latitude = separatedString.last
		
		guard let unwrappedLat = latitude, let unwrappedLong = longitude else {
			return ("","")
		}
		
		self.latitude = unwrappedLat
		self.longitude = unwrappedLong
		return (self.latitude, self.longitude)
	}
	
	private func getCitiesNames() -> [String] {
		var names = [String]()
		for city in data {
			let cityname = "\(city.name)"
			let countryName = "\(city.country)"
			let cityLat = city.lat
			let cityLong = city.lng
			names.append(cityname + " " + countryName + " " + "lat: " + cityLat + " " + "lng: " + cityLong)
		}
		return names
	}
}

//MARK: Search Bar Management
extension CitySelectionViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filteredData = getCitiesNames()
		
		filteredData = searchText.isEmpty ? filteredData : filteredData.filter { (item: String) -> Bool in
			// If dataItem matches the searchText, return true to include it
			return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
		}
		resultTableView.reloadData()
	}
}

//MARK: Table View Management
extension CitySelectionViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor.customGolden
		cell.selectedBackgroundView = backgroundView
		cell.setSelected(false, animated: false)
		cell.textLabel?.text = filteredData[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let unwrappedCell = tableView.cellForRow(at: indexPath) else {
			return
		}
		
		let currentCell = unwrappedCell
		guard let unwrappedTextLabel = currentCell.textLabel, var unwrappedText = unwrappedTextLabel.text else {
			return
		}
		selectedCity = unwrappedText
		cityNameSearchTextField.text = keepOnlyCity(name: &unwrappedText)
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
		
		viewModel.dataUpdater = { data in
			self.data = data
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
