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
        button.setTitleColor(.purple, for: .normal)
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
    
    let textfieldDescription: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let buttonCategory: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Category", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Select Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonAddExpense: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Expense", for: .normal)
        button.backgroundColor = .purple
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
        
        let imageStackView = UIStackView(arrangedSubviews: [expenseImageView, buttonAddPhoto])
        imageStackView.axis = .vertical
        imageStackView.alignment = .center
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let dateStackView = UIStackView(arrangedSubviews: [labelDate, pickerDate])
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.spacing = 8
        dateStackView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [
            imageStackView,
            textfieldAmount,
            textfieldDescription,
            buttonCategory,
            dateStackView,
        ])
        
        let buttonStackView = UIStackView(arrangedSubviews: [
            buttonAddExpense,
            buttonCancel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        buttonStackView.alignment = .fill
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
            stackView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            expenseImageView.heightAnchor.constraint(equalToConstant: 150),
            expenseImageView.widthAnchor.constraint(equalToConstant: 150),
            
            buttonAddExpense.heightAnchor.constraint(equalToConstant: 50),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
