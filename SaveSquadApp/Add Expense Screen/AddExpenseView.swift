//
//  AddExpenseView.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/19/24.
//

import UIKit

class AddExpenseView: UIView {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Expense"
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
    
    let expenseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let buttonAddPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(Utilities.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let textfieldAmount: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let imageAmount: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "dollarsign")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let textfieldDescription: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let imageDescription: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    let buttonCategory: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        button.setTitle("Select Category", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let imageCategory: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "square.grid.2x2")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Select Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageDate: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let pickerDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let buttonCancel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderColor = Utilities.purple.cgColor
        button.setTitleColor(Utilities.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let buttonAddExpense: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Expense", for: .normal)
        button.backgroundColor = Utilities.purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pickerDate.minimumDate = Date()
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        
        // Image and button stack (expenseImageView and buttonAddPhoto)
        let imageStackView = UIStackView(arrangedSubviews: [expenseImageView, buttonAddPhoto])
        imageStackView.axis = .vertical
        imageStackView.alignment = .center
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Amount input stack
        let amountStackView = UIStackView(arrangedSubviews: [imageAmount, textfieldAmount])
        amountStackView.axis = .horizontal
        amountStackView.alignment = .center
        amountStackView.spacing = 10
        amountStackView.distribution = .fillProportionally
        amountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Description input stack
        let descriptionStackView = UIStackView(arrangedSubviews: [imageDescription, textfieldDescription])
        descriptionStackView.axis = .horizontal
        descriptionStackView.alignment = .center
        descriptionStackView.spacing = 10
        descriptionStackView.distribution = .fillProportionally
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Category input stack
        let categoryStackView = UIStackView(arrangedSubviews: [imageCategory, buttonCategory])
        categoryStackView.axis = .horizontal
        categoryStackView.alignment = .center
        categoryStackView.spacing = 10
        categoryStackView.distribution = .fillProportionally
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Date input stack with image and label
        let dateStackView = UIStackView(arrangedSubviews: [imageDate, labelDate, pickerDate])
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.spacing = 10
        dateStackView.translatesAutoresizingMaskIntoConstraints = false

        // Main stack view
        let stackView = UIStackView(arrangedSubviews: [
            imageStackView,
            amountStackView,
            descriptionStackView,
            categoryStackView,
            dateStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Button stack for 'Add Expense' and 'Cancel'
        let buttonStackView = UIStackView(arrangedSubviews: [
            buttonCancel,
            buttonAddExpense
        ])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        
        
        // Constraints for the title section
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: titleBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleBackgroundView.centerYAnchor, constant: 30)
        ])
        
        // Main stack view constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // Button stack view constraints
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
        ])
        
        // Image and button size constraints
        NSLayoutConstraint.activate([
            expenseImageView.heightAnchor.constraint(equalToConstant: 150),
            expenseImageView.widthAnchor.constraint(equalToConstant: 150),
            
            buttonAddExpense.heightAnchor.constraint(equalToConstant: 50),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            imageAmount.heightAnchor.constraint(equalToConstant: 20),
            imageAmount.widthAnchor.constraint(equalToConstant: 20),
            
            imageDescription.heightAnchor.constraint(equalToConstant: 20),
            imageDescription.widthAnchor.constraint(equalToConstant: 20),
            
            imageCategory.heightAnchor.constraint(equalToConstant: 20),
            imageCategory.widthAnchor.constraint(equalToConstant: 20),
            
            imageDate.heightAnchor.constraint(equalToConstant: 20),
            imageDate.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
