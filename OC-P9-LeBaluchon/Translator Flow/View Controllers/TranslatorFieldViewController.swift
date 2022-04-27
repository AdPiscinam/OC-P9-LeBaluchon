// TranslatorFieldViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

class TranslatorFieldViewController: UIViewController {
    
    weak var coordinator: TranslatorFieldCoordinator?
    var viewModel: TranslatorViewModel!
    
    let textToTranslate: UITextView = {
        let text = UITextView()
        text.isEditable = true
        text.backgroundColor = .gray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to: TranslatorViewModel){
        viewModel.modalTitleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.textToTranslateUpdater = { [weak self] text in
            self?.textToTranslate.text = text
        }
    
    }
    
    func setupUI() {
        view.addSubview(textToTranslate)
        textToTranslate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textToTranslate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        textToTranslate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        textToTranslate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        let okBarButtonItem = UIBarButtonItem(title: "Translate", style: .done, target: self, action: #selector(translate))
        self.navigationItem.rightBarButtonItem  = okBarButtonItem
    }
    
    @objc func translate() {
        coordinator?.dismiss()
    }
    
}
