// ViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class ConverterViewController: UIViewController {
    weak var coordinator: ConverterCoordinator?
    var viewModel: ConverterViewModel!
    
    let amountUpperLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .customLightBrown
        label.textAlignment = .right
        label.textColor = .customScriptureGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    let downerTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .customLightBrown
        field.keyboardType = .decimalPad
        field.textAlignment = .right
        field.textColor = .customGolden
        field.tintColor = .clear
        field.attributedPlaceholder = NSAttributedString( string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var upperCurrencyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .customScriptureGray
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downerCurrencyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .customGolden
        label.layer.masksToBounds = true
        label.textAlignment = .center
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
        stack.backgroundColor = .customLightBrown
        return stack
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        button.tintColor = .customGolden
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .customScriptureGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate"
        label.backgroundColor = .customLightBrown
        label.textAlignment = .center
        label.textColor = .customGolden
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    @objc func fetchData() {
        guard let base = downerCurrencyLabel.text else {
            return
        }
        
        guard let destination = upperCurrencyLabel.text else {
            return
        }
         
        viewModel.getConversion(baseCode: base, destinationCode: destination)
    }
    
    @objc func selectConversionCurrencies() {
        coordinator?.startCurrencySelection()
    }
    
    func showMessage(errorMessage: String) {
        coordinator?.showErrorAlert(errorMessage: errorMessage)
    }

    func updateCurrenciesNames(base: String, destination: String) {
        viewModel.baseUpdater?(base)
        viewModel.destinationUpdater?(destination)
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
        if textField.text == "" {
            textField.text = "0"
            textField.text = ""
        }
       
        guard let unwrappedAmount = textField.text else {
            return
        }
        
        guard let doubledAmount = Double(unwrappedAmount) else {
            return
        }
        
        viewModel.doubledAmount = doubledAmount
    }
}

//MARK: View Model Binding
extension ConverterViewController {
    func bind(to: ConverterViewModel){
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        viewModel.resultAmountUpdater = { [weak self] text in
            self?.amountUpperLabel.text = text
        }
        viewModel.dateUpdater = { [weak self] text in
            self?.dateLabel.text = text
        }
        
        viewModel.rateUpdater = { [weak self] text in
            self?.currencyRateLabel.text = text
        }
        viewModel.baseUpdater = { [weak self] text in
            self?.downerCurrencyLabel.text = text
        }
        
        viewModel.destinationUpdater = { [weak self] text in
            self?.upperCurrencyLabel.text = text
        }
        
        viewModel.onErrorHandling = {  error in
            self.showMessage(errorMessage: error)
        }
    }
}

//MARK: User Interface Setup
extension ConverterViewController {
    private func setupUI() {
        view.backgroundColor = .customBackground
        
        self.hideKeyboardWhenTappedAround()
        view.addSubview(amountUpperLabel)
        view.addSubview(downerTextField)
        tabBarController?.tabBar.tintColor = .customOrange
        tabBarController?.tabBar.barTintColor = .customLightBrown
        downerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        amountUpperLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        amountUpperLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        amountUpperLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        amountUpperLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        downerTextField.topAnchor.constraint(equalTo: amountUpperLabel.bottomAnchor, constant: 1).isActive = true
        downerTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        downerTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        downerTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        amountUpperLabel.addSubview(upperCurrencyLabel)
        upperCurrencyLabel.centerYAnchor.constraint(equalTo: amountUpperLabel.centerYAnchor).isActive = true
        upperCurrencyLabel.leadingAnchor.constraint(equalTo: amountUpperLabel.leadingAnchor, constant: 16).isActive = true
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
