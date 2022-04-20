// CurrencySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class CurrencySelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    weak var coordinator: CurrencySelectionCoordinator?
    var ratesCityCode: [String: String] = [:]
    var currenciesArray: [String] = []
    
    let destinationCurrencyPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        destinationCurrencyPickerView.delegate = self
        destinationCurrencyPickerView.dataSource = self
        destinationCurrencyPickerView.reloadAllComponents()
        view.backgroundColor = .orange
        title = "Currency"
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(okay))
        view.addSubview(destinationCurrencyPickerView)
        destinationCurrencyPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        destinationCurrencyPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        destinationCurrencyPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
   }
    
    
    func populateData() {
        for (code, _) in Currency.jsonData {
            ratesCityCode[code] = Currency.jsonData[code]?.name
        }
        self.currenciesArray = createArrayFormDictionnary(dict: ratesCityCode)
        
    }
    
    private func createArrayFormDictionnary(dict: [String: String]) -> [String]{
        var array: [String] = []
        for (key, value) in dict {
            array.append(key + " - \(value)")
        }
        
        return array.sorted()
    }
    
    var convertToCurrencyCode = ""
    var baseCurrencyCode = ""
    
    var updateContactClosure: ((ConversionResponse) -> Void)?
    
    @objc func okay() {
        convertToCurrencyCode = getCurrenciesCode(pickerView: self.destinationCurrencyPickerView)
        coordinator?.update(base: "EUR", destination: convertToCurrencyCode)
       
        ConversionNetwork.shared.getData(baseCode: "EUR", destinationCode: convertToCurrencyCode) { [self] (success, response) in
            if success, let response = response {

                coordinator?.update(response: response)

            }
        }
        coordinator?.dismiss()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getCurrenciesCode(pickerView: UIPickerView) -> String {
        let currencyIndex = pickerView.selectedRow(inComponent: 0)
        let currency = currenciesArray[currencyIndex]
        let currencyCode = currency.split(separator: " ").first!
        return String(currencyCode)
    }
    
    func didSelectCurrency(convertToCurrencyCode: String, baseCurrencyCode: String) {
        self.convertToCurrencyCode = convertToCurrencyCode
        self.baseCurrencyCode = baseCurrencyCode
    }
    
}

extension CurrencySelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  ratesCityCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenciesArray[row]
    }
}
