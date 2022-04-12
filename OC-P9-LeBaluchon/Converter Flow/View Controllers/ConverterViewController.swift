// ViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class ConverterViewController: UIViewController {
  
    
    
    weak var coordinator: ConverterCoordinator?
    private var viewModel = ConverterViewModel()
   
    // User Interface
    let upperLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.backgroundColor = .green
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let downerTextField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.placeholder = "0"
        field.backgroundColor = .green
        field.keyboardType = .decimalPad
        field.textAlignment = .right
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var upperCurrencyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.text = "USD"
        label.layer.cornerRadius = 20
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectConversionCurrencies))
        label.addGestureRecognizer(tap)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downerCurrencyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.text = "EUR"
        label.layer.cornerRadius = 20
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectConversionCurrencies))
        label.addGestureRecognizer(tap)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .yellow
        return stack
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "31/03/2022 12:16"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyRateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 EUR = 1,11 USD"
        label.backgroundColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Converter"
        setupUI()
        bindViewModel()
        viewModel.viewDidLoad()
        
    }
    
    
    
    func bindViewModel() {
        viewModel.resultUpdater = { [weak self] text in
            self?.upperLabel.text = text
        }
        viewModel.dateUpdater = { [weak self] text in
            self?.dateLabel.text = text
        }
        viewModel.rateUpdater = { [weak self] text in
            self?.currencyRateLabel.text = text
        }
        
    }
    var selectedConvertToCurrencyCode = "USD"
    var selectedBaseCurrencyCode = "EUR"
    
    
    func update(base: String, destination: String) {
        upperLabel.text =  destination
        downerTextField.text = base
    }
    

   
    @objc func fetchData() {
        
    }
    
    @objc func selectConversionCurrencies() {
        coordinator?.startCurrencySelection()
    }
    
}
//MARK: Keyboard Management
extension ConverterViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: TextField Management
extension ConverterViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        fetchData()
        if textField.text == "" {
            textField.text = "0"
            fetchData()
            textField.text = ""
        }
    }
}

//MARK: User Interface
extension ConverterViewController {
    private func setupUI() {
        self.hideKeyboardWhenTappedAround()
        view.addSubview(upperLabel)
        view.addSubview(downerTextField)
        
        downerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        upperLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        upperLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        upperLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        upperLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        downerTextField.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 1).isActive = true
        downerTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        downerTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        downerTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        upperLabel.addSubview(upperCurrencyLabel)
        upperCurrencyLabel.centerYAnchor.constraint(equalTo: upperLabel.centerYAnchor).isActive = true
        upperCurrencyLabel.leadingAnchor.constraint(equalTo: upperLabel.leadingAnchor, constant: 16).isActive = true
        upperCurrencyLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        upperCurrencyLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        downerTextField.addSubview(downerCurrencyLabel)
        downerCurrencyLabel.centerYAnchor.constraint(equalTo: downerTextField.centerYAnchor).isActive = true
        downerCurrencyLabel.leadingAnchor.constraint(equalTo: downerTextField.leadingAnchor, constant: 16).isActive = true
        downerCurrencyLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        downerCurrencyLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(refreshButton)
        view.addSubview(verticalStackView)
        
        refreshButton.topAnchor.constraint(equalTo: downerTextField.bottomAnchor, constant: 16).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(currencyRateLabel)
        verticalStackView.centerYAnchor.constraint(equalTo: refreshButton.centerYAnchor).isActive = true
        verticalStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
}
