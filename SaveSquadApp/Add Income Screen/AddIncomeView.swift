//
//  AddIncomeView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class AddIncomeView: UIView {
    
    var contentWrapper:UIScrollView!
    var amountStack: UIStackView!
    var amountPic: UIImageView!
    var amountTextField: UITextField!
    var descriptionStack: UIStackView!
    var descriptionPic: UIImageView!
    var descriptionTextField: UITextField!
    var frequencyStack: UIStackView!
    var frequencyPic: UIImageView!
    var frequencyButton: UIButton!
    var datePic: UIImageView!
    var datePicker: UIDatePicker!
    var actionStack: UIStackView!
    var cancelButton: UIButton!
    var addButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupContentWrapper()
        setupAmountStack()
        setupAmountPic()
        setupAmountTextField()
        setupDescriptionStack()
        setupDescriptionPic()
        setupDescriptionTextField()
        setupFrequencyStack()
        setupFrequencyPic()
        setupFrequencyButton()
        setupDatePic()
        setupDatePicker()
        setupActionStack()
        setupCancelButton()
        setupAddButton()
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupAmountStack(){
        amountStack = UIStackView()
        amountStack.axis = .horizontal
        amountStack.alignment = .center
        amountStack.distribution = .fillProportionally
        amountStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(amountStack)
    }
    
    func setupAmountPic(){
        amountPic = UIImageView()
        amountPic.image = UIImage(systemName: "dollarsign")?.withRenderingMode(.alwaysTemplate)
        amountPic.tintColor = .black
        amountPic.contentMode = .scaleAspectFit
        amountPic.backgroundColor = .white
        amountPic.clipsToBounds = true
        amountPic.layer.masksToBounds = true
        amountPic.translatesAutoresizingMaskIntoConstraints = false
        amountStack.addArrangedSubview(amountPic)
    }
    
    func setupAmountTextField() {
        amountTextField = UITextField()
        amountTextField.placeholder = "Amount"
        amountTextField.borderStyle = .roundedRect
        amountTextField.keyboardType = .decimalPad
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountStack.addArrangedSubview(amountTextField)
    }
    
    func setupDescriptionStack(){
        descriptionStack = UIStackView()
        descriptionStack.axis = .horizontal
        descriptionStack.alignment = .center
        descriptionStack.distribution = .fillProportionally
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(descriptionStack)
    }
    
    func setupDescriptionPic(){
        descriptionPic = UIImageView()
        descriptionPic.image = UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysTemplate)
        descriptionPic.tintColor = .black
        descriptionPic.contentMode = .scaleAspectFit
        descriptionPic.backgroundColor = .white
        descriptionPic.clipsToBounds = true
        descriptionPic.layer.masksToBounds = true
        descriptionPic.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.addArrangedSubview(descriptionPic)
    }
    
    func setupDescriptionTextField() {
        descriptionTextField = UITextField()
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.addArrangedSubview(descriptionTextField)
    }
    
    func setupFrequencyStack(){
        frequencyStack = UIStackView()
        frequencyStack.axis = .horizontal
        frequencyStack.alignment = .center
        frequencyStack.distribution = .fillProportionally
        frequencyStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(frequencyStack)
    }
    
    func setupFrequencyPic(){
        frequencyPic = UIImageView()
        frequencyPic.image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysTemplate)
        frequencyPic.tintColor = .black
        frequencyPic.contentMode = .scaleAspectFit
        frequencyPic.backgroundColor = .white
        frequencyPic.clipsToBounds = true
        frequencyPic.layer.masksToBounds = true
        frequencyPic.translatesAutoresizingMaskIntoConstraints = false
        frequencyStack.addArrangedSubview(frequencyPic)
    }
    
    func setupFrequencyButton(){
        frequencyButton = UIButton(type: .system)
        frequencyButton.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        frequencyButton.setTitle("Select Frequency", for: .normal)
        frequencyButton.layer.borderWidth = 1
        frequencyButton.layer.borderColor = UIColor.lightGray.cgColor
        frequencyButton.layer.cornerRadius = 5
        frequencyButton.translatesAutoresizingMaskIntoConstraints = false
        frequencyButton.setTitleColor(UIColor.black, for: .normal)
        frequencyStack.addArrangedSubview(frequencyButton)
    }
    
    func setupDatePic(){
        datePic = UIImageView()
        datePic.image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        datePic.tintColor = .black
        datePic.contentMode = .scaleAspectFit
        datePic.backgroundColor = .white
        datePic.clipsToBounds = true
        datePic.layer.masksToBounds = true
        datePic.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(datePic)
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
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.backgroundColor = UIColor.white.cgColor
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        actionStack.addArrangedSubview(cancelButton)
    }
    
    func setupAddButton(){
        addButton = UIButton(type: .system)
        addButton.setTitle("Add Income", for: .normal)
        addButton.layer.cornerRadius = 5
        addButton.layer.backgroundColor = UIColor.black.cgColor
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitleColor(UIColor.white, for: .normal)
        actionStack.addArrangedSubview(addButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            amountStack.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 16),
            amountStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            amountStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            amountStack.heightAnchor.constraint(equalToConstant: 60),
            
            amountTextField.widthAnchor.constraint(equalTo: amountStack.widthAnchor, multiplier: 0.9),
            
            descriptionStack.topAnchor.constraint(equalTo: amountStack.bottomAnchor, constant: 16),
            descriptionStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            descriptionStack.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextField.widthAnchor.constraint(equalTo: descriptionStack.widthAnchor, multiplier: 0.9),
            
            frequencyStack.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 16),
            frequencyStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            frequencyStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            frequencyStack.heightAnchor.constraint(equalToConstant: 60),
            
            frequencyButton.widthAnchor.constraint(equalTo: frequencyStack.widthAnchor, multiplier: 0.9),
            
            datePic.topAnchor.constraint(equalTo: frequencyStack.bottomAnchor, constant: 32),
            datePicker.topAnchor.constraint(equalTo: datePic.topAnchor, constant: -8),
            datePic.leadingAnchor.constraint(equalTo: frequencyPic.leadingAnchor),
            datePicker.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            datePic.widthAnchor.constraint(equalTo: frequencyPic.widthAnchor),
            datePic.heightAnchor.constraint(equalTo: frequencyPic.heightAnchor),
            
            actionStack.topAnchor.constraint(equalTo: datePic.bottomAnchor, constant: 32),
            actionStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            actionStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            actionStack.heightAnchor.constraint(equalToConstant: 70),
            
            cancelButton.widthAnchor.constraint(equalTo: actionStack.widthAnchor, multiplier: 0.45),
            addButton.widthAnchor.constraint(equalTo: actionStack.widthAnchor, multiplier: 0.45),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            actionStack.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
