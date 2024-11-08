//
//  CreateSavingsGoalView.swift
//  SaveSquadApp
//
//  Created by Bubesh Dev on 11/7/24.
//

import UIKit

class CreateSavingsGoalView: UIView {
    
    // Title label for "Create Savings Goal"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Savings Goal"
        label.font = UIFont.boldSystemFont(ofSize: 24) // Large font size
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Gray background view for the title
    private let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Circular image view placeholder for goal image
    let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit  // Scale down to fit within the circular frame
        imageView.layer.cornerRadius = 75 // Half of width and height for circular shape
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40)) // Smaller camera icon
        imageView.tintColor = .gray
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Button to select or take a photo
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Text fields for goal details
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
    
    // Label and date picker for target date
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
    
    // Cancel and Create Goal buttons
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let createGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Goal", for: .normal)
        button.backgroundColor = .purple
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
        
        // Add the gray background and title label
        addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        
        // Create a vertical stack for the image and upload button
        let imageStackView = UIStackView(arrangedSubviews: [goalImageView, addPhotoButton])
        imageStackView.axis = .vertical
        imageStackView.alignment = .center
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a horizontal stack for the target date label and picker
        let targetDateStackView = UIStackView(arrangedSubviews: [targetDateLabel, targetDatePicker])
        targetDateStackView.axis = .horizontal
        targetDateStackView.alignment = .center
        targetDateStackView.spacing = 8
        targetDateStackView.translatesAutoresizingMaskIntoConstraints = false

        // Arrange all components in a vertical stack
        let stackView = UIStackView(arrangedSubviews: [
            imageStackView,
            nameTextField,
            amountTextField,
            descriptionTextField,
            targetDateStackView,
            createGoalButton,
            cancelButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Constraints for title background and title label
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 120), // Increased height
            
            titleLabel.centerXAnchor.constraint(equalTo: titleBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleBackgroundView.centerYAnchor, constant: 30) // Adjusted vertical position
        ])
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // Constraints for specific elements
        NSLayoutConstraint.activate([
            goalImageView.heightAnchor.constraint(equalToConstant: 150),
            goalImageView.widthAnchor.constraint(equalToConstant: 150),
            
            createGoalButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
