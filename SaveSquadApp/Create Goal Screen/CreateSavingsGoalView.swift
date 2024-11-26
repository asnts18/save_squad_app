//
//  CreateSavingsGoalView.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//

import UIKit

class CreateSavingsGoalView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Savings Goal"
        label.font = UIFont.boldSystemFont(ofSize: 24) // Large font size
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40))
        imageView.tintColor = .gray
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(Utilities.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Goal Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let targetDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Target Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(Utilities.purple, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = Utilities.purple.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let createGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Goal", for: .normal)
        button.backgroundColor = Utilities.purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        targetDatePicker.minimumDate = Date() 
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        
        let imageStackView = UIStackView(arrangedSubviews: [goalImageView, addPhotoButton])
        imageStackView.axis = .vertical
        imageStackView.alignment = .center
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let targetDateStackView = UIStackView(arrangedSubviews: [targetDateLabel, targetDatePicker])
        targetDateStackView.axis = .horizontal
        targetDateStackView.alignment = .center
        targetDateStackView.spacing = 8
        targetDateStackView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [
            imageStackView,
            nameTextField,
            amountTextField,
            descriptionTextField,
            targetDateStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let buttonStackView = UIStackView(arrangedSubviews: [
            cancelButton,
            createGoalButton
        ])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
    
        
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: titleBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleBackgroundView.centerYAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
        ])
        

        NSLayoutConstraint.activate([
            goalImageView.heightAnchor.constraint(equalToConstant: 150),
            goalImageView.widthAnchor.constraint(equalToConstant: 150),
            
            createGoalButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
