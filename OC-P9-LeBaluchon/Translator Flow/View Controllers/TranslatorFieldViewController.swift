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
        text.textColor = .systemBackground
        text.backgroundColor = .customLightBrown
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        textToTranslate.delegate = self
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    @objc func translate() {
        coordinator?.updateTranslation(text: textToTranslate.text)
        coordinator?.dismiss()
    }
}

//MARK: Text View Management
extension TranslatorFieldViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        viewModel.textToTranslateUpdater?(textView.text)
    }
}

//MARK: View Model Binding
extension TranslatorFieldViewController {
    func bind(to: TranslatorViewModel){
        viewModel.modalTitleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.textToTranslateUpdater = { [weak self] text in
            self?.textToTranslate.text = text
        }
    }
}

//MARK: User Interface Setup
extension TranslatorFieldViewController {
    func setupUI() {
        view.backgroundColor = .customLightBrown
        navigationController?.navigationBar.tintColor = UIColor.customOrange
        view.addSubview(textToTranslate)
        textToTranslate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textToTranslate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        textToTranslate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        textToTranslate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        let okBarButtonItem = UIBarButtonItem(title: "Translate", style: .done, target: self, action: #selector(translate))
        self.navigationItem.rightBarButtonItem = okBarButtonItem
    }
}
