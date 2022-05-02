// TranslatorViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 08/04/2022
// 

import UIKit

class TranslatorViewController: UIViewController {
    
    weak var coordinator: TranslatorCoordinator?
    var viewModel: TranslatorViewModel!
    
    let frenchText: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.backgroundColor = .customLightBrown
        text.textColor = .customGolden
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let englishText: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.backgroundColor = .customLightBrown
        text.textColor = .lightGray
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
    
    private func setupUI() {
        view.backgroundColor = .customBackground
        view.addSubview(englishText)
        view.addSubview(frenchText)
        englishText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        englishText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        englishText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        englishText.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        frenchText.topAnchor.constraint(equalTo: englishText.bottomAnchor, constant: 16).isActive = true
        frenchText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        frenchText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        frenchText.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func addTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showModal))
        tap.cancelsTouchesInView = false
        frenchText.addGestureRecognizer(tap)
    }
    
    func updateTranslation(text: String) {
        frenchText.text = text
    }
    
    @objc func showModal() {
        coordinator?.startTranslatorField()
    }
}

//MARK: Binding
extension TranslatorViewController {
    func bind(to: TranslatorViewModel){
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.englishTextUpdater = { [weak self] text in
            self?.englishText.text = text
        }
        
        viewModel.frenchTextUpdater = { [weak self] text in
            self?.frenchText.text = text
        }
    }
}
