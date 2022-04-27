// TranslatorFieldViewController.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import UIKit

class TranslatorFieldViewController: UIViewController {
    
    weak var coordinator: TranslatorFieldCoordinator?
    
    let textToTranslate: UITextView = {
        let text = UITextView()
        text.text = "Write"
        text.isEditable = true
        text.backgroundColor = .gray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Enter Text"
        setupUI()
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
        print("translating...   ")
    }
    
}
