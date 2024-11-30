//
//  EditIncomeView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/29/24.
//

import UIKit

class EditIncomeView: UIView {
    
    var titleBackgroundView: UIView!
    var contentWrapper: UIScrollView!
    var labelDescription: UILabel!
    var textFieldDescription: UITextField!
    var labelAmount: UILabel!
    var textFieldAmount: UITextField!
    var labelFrequency: UILabel!
    var buttonFrequency: UIButton!
    var labelDate: UILabel!
    var datePicker: UIDatePicker!
    var actionStack: UIStackView!
    var cancelButton: UIButton!
    var saveButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupContentWrapper()
        setupLabelDescription()
        setupTextFieldDescription()
        setupLabelAmount()
        setupTextFieldAmount()
        setupLabelFrequency()
        setupButtonFrequency()
        setupLabelDate()
        setupDatePicker()
        setupActionStack()
        setupCancelButton()
        setupSaveButton()
        initConstraints()
    }

    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.delaysContentTouches = false
        contentWrapper.canCancelContentTouches = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupLabelDescription() {
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 24)
        labelDescription.textAlignment = .center
        labelDescription.text = "Description:"
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelDescription)
    }
    
    func setupTextFieldDescription() {
        textFieldDescription = UITextField()
        textFieldDescription.borderStyle = .roundedRect
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldDescription)
    }
    
    func setupLabelAmount() {
        labelAmount = UILabel()
        labelAmount.font = UIFont.boldSystemFont(ofSize: 24)
        labelAmount.textAlignment = .center
        labelAmount.text = "Amount:"
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelAmount)
    }
    
    func setupTextFieldAmount() {
        textFieldAmount = UITextField()
        textFieldAmount.borderStyle = .roundedRect
        textFieldAmount.keyboardType = .decimalPad
        textFieldAmount.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldAmount)
    }
    
    func setupLabelFrequency() {
        labelFrequency = UILabel()
        labelFrequency.font = UIFont.boldSystemFont(ofSize: 24)
        labelFrequency.textAlignment = .center
        labelFrequency.text = "Frequency:"
        labelFrequency.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelFrequency)
    }
    
    func setupButtonFrequency() {
        buttonFrequency = UIButton(type: .system)
        buttonFrequency.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        buttonFrequency.layer.borderWidth = 1
        buttonFrequency.layer.borderColor = UIColor.lightGray.cgColor
        buttonFrequency.layer.cornerRadius = 5
        buttonFrequency.translatesAutoresizingMaskIntoConstraints = false
        buttonFrequency.setTitleColor(UIColor.black, for: .normal)
        contentWrapper.addSubview(buttonFrequency)
    }
    
    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 24)
        labelDate.textAlignment = .center
        labelDate.text = "Date:"
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelDate)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(datePicker)
    }
    
    func setupActionStack(){
        actionStack = UIStackView()
        actionStack.axis = .horizontal
        actionStack.alignment = .center
        actionStack.distribution = .fillProportionally
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(actionStack)
    }
    
    func setupCancelButton(){
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = Utilities.purple.cgColor
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.backgroundColor = UIColor.white.cgColor
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(Utilities.purple, for: .normal)
        actionStack.addArrangedSubview(cancelButton)
    }
    
    func setupSaveButton(){
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.layer.backgroundColor = Utilities.purple.cgColor
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitleColor(UIColor.white, for: .normal)
        actionStack.addArrangedSubview(saveButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 55),
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            labelDescription.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            textFieldDescription.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            textFieldDescription.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            textFieldDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelAmount.topAnchor.constraint(equalTo: textFieldDescription.bottomAnchor, constant: 20),
            labelAmount.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            textFieldAmount.topAnchor.constraint(equalTo: labelAmount.bottomAnchor, constant: 20),
            textFieldAmount.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            textFieldAmount.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            textFieldAmount.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            
            labelFrequency.topAnchor.constraint(equalTo: textFieldAmount.bottomAnchor, constant: 20),
            labelFrequency.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            buttonFrequency.topAnchor.constraint(equalTo: labelFrequency.bottomAnchor, constant: 20),
            buttonFrequency.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            buttonFrequency.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            buttonFrequency.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            
            labelDate.topAnchor.constraint(equalTo: buttonFrequency.bottomAnchor, constant: 20),
            labelDate.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            datePicker.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            actionStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32),
            actionStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            actionStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            actionStack.heightAnchor.constraint(equalToConstant: 70),
            
            cancelButton.widthAnchor.constraint(equalTo: actionStack.widthAnchor, multiplier: 0.45),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.widthAnchor.constraint(equalTo: actionStack.widthAnchor, multiplier: 0.45),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            actionStack.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
