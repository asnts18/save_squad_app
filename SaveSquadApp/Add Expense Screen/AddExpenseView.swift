//
//  AddExpenseView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class AddExpenseView: UIView {
    
    // MARK: - Properties
    var textFieldAmount: UITextField!
    var textFieldDescription: UITextField!
    var buttonAddExpense: UIButton!
    var buttonCancel: UIButton!
    var dropdownDate: UIDatePicker!
    var buttonSelectCategory: UIButton!
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        // set up methods
        setupTextFieldAmount()
        setupTextFieldDescription()
        setupButtonAddExpense()
        setupButtonCancel()
        setupButtonSelectCategory()
        setupDropdownDate()
        
        // initialize constraints
        initConstraints()
    }
    
    // MARK: - Setup Methods
    func setupTextFieldAmount() {
        textFieldAmount = UITextField()
        textFieldAmount.placeholder = "Amount"
        textFieldAmount.borderStyle = .roundedRect
        textFieldAmount.autocapitalizationType = .none
        textFieldAmount.keyboardType = .decimalPad
        textFieldAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAmount)
    }
    
    func setupTextFieldDescription() {
        textFieldDescription = UITextField()
        textFieldDescription.placeholder = "Description"
        textFieldDescription.borderStyle = .roundedRect
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldDescription)
    }
    
    func setupButtonSelectCategory() {
        buttonSelectCategory = UIButton(type: .system)
        buttonSelectCategory.setTitle("Select the type of expense:", for: .normal)
        buttonSelectCategory.showsMenuAsPrimaryAction = true
        buttonSelectCategory.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectCategory)
        
    }
    
    func setupDropdownDate() {
        dropdownDate = UIDatePicker()
         dropdownDate.datePickerMode = .date
         dropdownDate.translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(dropdownDate)
    }
    
    func setupButtonAddExpense() {
        buttonAddExpense = UIButton(type: .system)
        buttonAddExpense.setTitle("Add Expense", for: .normal)
        buttonAddExpense.backgroundColor = .systemBlue
        buttonAddExpense.setTitleColor(.white, for: .normal)
        buttonAddExpense.layer.cornerRadius = 5
        buttonAddExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAddExpense)
    }
    
    func setupButtonCancel() {
        buttonCancel = UIButton(type: .system)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.backgroundColor = .systemGray
        buttonCancel.setTitleColor(.white, for: .normal)
        buttonCancel.layer.cornerRadius = 5
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCancel)
    }
    
    
    // MARK: - Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Amount TextField constraints
            textFieldAmount.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            textFieldAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldAmount.heightAnchor.constraint(equalToConstant: 40),
            
            // Description TextField constraints
            textFieldDescription.topAnchor.constraint(equalTo: textFieldAmount.bottomAnchor, constant: 20),
            textFieldDescription.leadingAnchor.constraint(equalTo: textFieldAmount.leadingAnchor),
            textFieldDescription.trailingAnchor.constraint(equalTo: textFieldAmount.trailingAnchor),
            textFieldDescription.heightAnchor.constraint(equalToConstant: 40),
            
            // Select Category Button constraints
            buttonSelectCategory.topAnchor.constraint(equalTo: textFieldDescription.bottomAnchor, constant: 20),
            buttonSelectCategory.leadingAnchor.constraint(equalTo: textFieldAmount.leadingAnchor),
            buttonSelectCategory.trailingAnchor.constraint(equalTo: textFieldAmount.trailingAnchor),
            buttonSelectCategory.heightAnchor.constraint(equalToConstant: 50),
            
            // Dropdown Date constraints
            dropdownDate.topAnchor.constraint(equalTo: buttonSelectCategory.bottomAnchor, constant: 20),
            dropdownDate.leadingAnchor.constraint(equalTo: textFieldAmount.leadingAnchor),
            dropdownDate.trailingAnchor.constraint(equalTo: textFieldAmount.trailingAnchor),
            dropdownDate.heightAnchor.constraint(equalToConstant: 50),
            
            // Add Expense Button constraints
            buttonAddExpense.topAnchor.constraint(equalTo: dropdownDate.bottomAnchor, constant: 20),
            buttonAddExpense.leadingAnchor.constraint(equalTo: textFieldAmount.leadingAnchor),
            buttonAddExpense.trailingAnchor.constraint(equalTo: textFieldAmount.trailingAnchor),
            buttonAddExpense.heightAnchor.constraint(equalToConstant: 50),
            
            // Cancel Button constraints
            buttonCancel.topAnchor.constraint(equalTo: buttonAddExpense.bottomAnchor, constant: 20),
            buttonCancel.leadingAnchor.constraint(equalTo: textFieldAmount.leadingAnchor),
            buttonCancel.trailingAnchor.constraint(equalTo: textFieldAmount.trailingAnchor),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
