//
//  EditIncomeView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/29/24.
//

import UIKit

class EditIncomeView: UIView {
    
    var titleBackgroundView: UIView!
    var labelDescription: UILabel!
    var textFieldDescription: UITextField!
    var labelAmount: UILabel!
    var textFieldAmount: UITextField!
    var labelFrequency: UILabel!
    var buttonFrequency: UIButton!
    var labelDate: UILabel!
    var datePicker: UIDatePicker!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupLabelDescription()
        setupTextFieldDescription()
        setupLabelAmount()
        setupTextFieldAmount()
        setupLabelFrequency()
        setupButtonFrequency()
        setupLabelDate()
        setupDatePicker()
        initConstraints()
    }

    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupLabelDescription() {
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 24)
        labelDescription.textAlignment = .center
        labelDescription.text = "Description:"
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDescription)
    }
    
    func setupTextFieldDescription() {
        textFieldDescription = UITextField()
        textFieldDescription.borderStyle = .roundedRect
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldDescription)
    }
    
    func setupLabelAmount() {
        labelAmount = UILabel()
        labelAmount.font = UIFont.boldSystemFont(ofSize: 24)
        labelAmount.textAlignment = .center
        labelAmount.text = "Amount:"
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAmount)
    }
    
    func setupTextFieldAmount() {
        textFieldAmount = UITextField()
        textFieldAmount.borderStyle = .roundedRect
        textFieldAmount.keyboardType = .decimalPad
        textFieldAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAmount)
    }
    
    func setupLabelFrequency() {
        labelFrequency = UILabel()
        labelFrequency.font = UIFont.boldSystemFont(ofSize: 24)
        labelFrequency.textAlignment = .center
        labelFrequency.text = "Frequency:"
        labelFrequency.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelFrequency)
    }
    
    func setupButtonFrequency() {
        buttonFrequency = UIButton(type: .system)
        buttonFrequency.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        buttonFrequency.layer.borderWidth = 1
        buttonFrequency.layer.borderColor = UIColor.lightGray.cgColor
        buttonFrequency.layer.cornerRadius = 5
        buttonFrequency.translatesAutoresizingMaskIntoConstraints = false
        buttonFrequency.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(buttonFrequency)
    }
    
    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 24)
        labelDate.textAlignment = .center
        labelDate.text = "Date:"
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDate)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(datePicker)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 55),
            
            labelDescription.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldDescription.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            textFieldDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelAmount.topAnchor.constraint(equalTo: textFieldDescription.bottomAnchor, constant: 20),
            labelAmount.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldAmount.topAnchor.constraint(equalTo: labelAmount.bottomAnchor, constant: 20),
            textFieldAmount.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldAmount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelFrequency.topAnchor.constraint(equalTo: textFieldAmount.bottomAnchor, constant: 20),
            labelFrequency.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonFrequency.topAnchor.constraint(equalTo: labelFrequency.bottomAnchor, constant: 20),
            buttonFrequency.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonFrequency.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonFrequency.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelDate.topAnchor.constraint(equalTo: buttonFrequency.bottomAnchor, constant: 20),
            labelDate.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            datePicker.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
