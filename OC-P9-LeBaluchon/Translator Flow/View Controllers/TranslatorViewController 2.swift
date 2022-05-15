// TranslatorViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

final class TranslatorViewController: UIViewController {
    weak var coordinator: TranslatorCoordinator?
    var viewModel: TranslatorViewModel!
    
    let foreignText: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.backgroundColor = .customLightBrown
        text.textColor = .customGolden
        text.font = .systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let englishText: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.backgroundColor = .customLightBrown
        text.textColor = .lightGray
        text.font = .systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        addTapRecognizer()
    }

    func addTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showModal))
        tap.cancelsTouchesInView = false
        foreignText.addGestureRecognizer(tap)
    }
    
    func updateTranslation(text: String) {
        foreignText.text = text
        translate()
    }
    
    func showMessage(errorMessage: String) {
        coordinator?.showErrorAlert(errorMessage: errorMessage)
    }
    
    @objc func showModal() {
        coordinator?.startTranslatorField()
    }
    
    @objc func translate() {
        guard let text = foreignText.text else {
            return
        }
        viewModel.getTranslation(text: text)
    }
}

//MARK: - View Model Binding
extension TranslatorViewController {
    func bind(to: TranslatorViewModel){
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.onErrorHandling = {  error in
            self.showMessage(errorMessage: error)
        }
        
        viewModel.englishTextUpdater = { [weak self] text in
            self?.englishText.text = text
        }
        
        viewModel.foreignTextUpdater = { [weak self] text in
            self?.foreignText.text = text
        }
    }
}

//MARK: - User Interface Setup
extension TranslatorViewController {
    private func setupUI() {
        view.backgroundColor = .customBackground
        view.addSubview(englishText)
        view.addSubview(foreignText)
     
        englishText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        englishText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        englishText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        englishText.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        foreignText.topAnchor.constraint(equalTo: englishText.bottomAnchor, constant: 16).isActive = true
        foreignText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        foreignText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        foreignText.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
