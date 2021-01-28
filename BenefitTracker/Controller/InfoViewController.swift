//
//  InfoViewController.swift
//  BenefitTracker
//
//  Created by Valery Shel on 08.11.2020.
//

import UIKit

final class InfoViewController: UIViewController {
    
    let titleHeader: UILabel = {
        let label = UILabel()
        label.text = InfoHabitsStorage.header
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
        
    let infoApp: UITextView = {
        let textField = UITextView()
        textField.isScrollEnabled = true
        textField.text = InfoHabitsStorage.infoText
        textField.isEditable = false
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Информация"
        view.backgroundColor = .white

        setupSubview()
        setupConstraints()
    }

    private func setupSubview() {
        view.addSubviews(titleHeader, infoApp)
    
    }

    private func setupConstraints() {
        let constraints = [
            titleHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            infoApp.topAnchor.constraint(equalTo: titleHeader.bottomAnchor, constant: 16),
            infoApp.leadingAnchor.constraint(equalTo: titleHeader.leadingAnchor),
            infoApp.trailingAnchor.constraint(equalTo: titleHeader.trailingAnchor),
            infoApp.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
