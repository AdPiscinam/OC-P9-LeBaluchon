// CurrencySelectionViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class CurrencySelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    weak var coordinator: CurrencySelectionCoordinator?
    var viewModel: ConverterViewModel!
    
    var originCurrencyCode = ""
    var destinationCurrencyCode = "USD"
    
    let originCurrencyPickerView: UIPickerView = {
        let picker = UIPickerView()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originCurrencyPickerView.delegate = self
        originCurrencyPickerView.dataSource = self
        originCurrencyPickerView.reloadAllComponents()
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishSelecting()
    }
    
    func bind(to: ConverterViewModel){
        viewModel.modalTitleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.baseUpdater = { [weak self] baseCode in
            self?.originCurrencyCode = baseCode
        }
        
        viewModel.destinationUpdater = { [weak self] destinationCode in
            self?.destinationCurrencyCode = destinationCode
        }
    }
    
    @objc func okay() {
        originCurrencyCode = getCurrenciesCode(pickerView: self.originCurrencyPickerView)
        coordinator?.update(base: originCurrencyCode, destination: destinationCurrencyCode)
        coordinator?.fetchData()
        coordinator?.dismiss()
    }
    
    @objc func cancel() {
        coordinator?.dismiss()
    }
    
    func getCurrenciesCode(pickerView: UIPickerView) -> String {
        let currencyIndex = pickerView.selectedRow(inComponent: 0)
        let currency = viewModel.currenciesArray[currencyIndex]
        let currencyCode = currency.split(separator: " ").first!
        return String(currencyCode)
    }
}

extension CurrencySelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  viewModel.ratesCityCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currenciesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: viewModel.currenciesArray[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.customGolden])
            return attributedString
    }
    
}

extension CurrencySelectionViewController {
    private func setupUI() {
        view.backgroundColor = .customLightBrown
        navigationController?.navigationBar.tintColor = UIColor.customOrange
        
        let okBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okay))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        view.addSubview(originCurrencyPickerView)
        originCurrencyPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        originCurrencyPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        originCurrencyPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
}
