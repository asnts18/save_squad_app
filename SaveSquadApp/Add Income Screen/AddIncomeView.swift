//
//  AddIncomeView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class AddIncomeView: UIView {
    
    var titleBackgroundView: UIView!
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
    
    var dateStack: UIStackView!
    var dateLabel: UILabel!
    var datePic: UIImageView!
    var datePicker: UIDatePicker!
    
    var actionStack: UIStackView!
    var cancelButton: UIButton!
    var addButton: UIButton!
    
    var mainStack: UIStackView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupContentWrapper()
        setupMainStack()
        
        setupAmountStack()
        setupAmountPic()
        setupAmountTextField()
        
        setupDescriptionStack()
        setupDescriptionPic()
        setupDescriptionTextField()
        
        setupFrequencyStack()
        setupFrequencyPic()
        setupFrequencyButton()
        
        setupDateStack()
        setupDatePic()
        setupDateLabel()
        setupDatePicker()
        
        setupActionStack()
        setupCancelButton()
        setupAddButton()
                
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = Utilities.purple
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
    
    func setupMainStack() {
        mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 30
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(mainStack)
    }
    
    
    // MARK: Set up stack view for Amount text field
    func setupAmountStack(){
        amountStack = UIStackView()
        amountStack.axis = .horizontal
        amountStack.alignment = .center
        amountStack.distribution = .fillProportionally
        amountStack.spacing = 10
        amountStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(amountStack)
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
    
    // MARK: Set up stack view for Description text field
    func setupDescriptionStack(){
        descriptionStack = UIStackView()
        descriptionStack.axis = .horizontal
        descriptionStack.alignment = .center
        descriptionStack.spacing = 10
        descriptionStack.distribution = .fillProportionally
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(descriptionStack)
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
    
    // MARK: Set up stack view for Frequency dropdown
    func setupFrequencyStack(){
        frequencyStack = UIStackView()
        frequencyStack.axis = .horizontal
        frequencyStack.alignment = .center
        frequencyStack.spacing = 10
        frequencyStack.distribution = .fillProportionally
        frequencyStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(frequencyStack)
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
    
    // MARK: Set up stack view for Date dropdown
    func setupDateStack() {
        dateStack = UIStackView()
        dateStack.axis = .horizontal
        dateStack.alignment = .center
        dateStack.spacing = 10
        dateStack.distribution = .fillProportionally
        dateStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(dateStack)
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
        dateStack.addArrangedSubview(datePic)
    }
    
    func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "Select Date"
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.textColor = .darkGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateStack.addArrangedSubview(dateLabel)
    }

    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateStack.addArrangedSubview(datePicker)
    }

    // MARK: Set up stack view for Add and Cancel buttons
    func setupActionStack(){
        actionStack = UIStackView()
        actionStack.axis = .horizontal
        actionStack.alignment = .fill
        actionStack.spacing = 10
        actionStack.distribution = .fillEqually
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
    
    func setupAddButton(){
        addButton = UIButton(type: .system)
        addButton.setTitle("Add Income", for: .normal)
        addButton.layer.cornerRadius = 5
        addButton.layer.backgroundColor = Utilities.purple.cgColor
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitleColor(UIColor.white, for: .normal)
        actionStack.addArrangedSubview(addButton)
    }
    

    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // Main stack view constraints
            mainStack.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            // Button stack view constraints
            actionStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            actionStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            actionStack.bottomAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.bottomAnchor, constant: -50),
            
            // Button size constraints
            addButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Icon size constraints
            amountPic.heightAnchor.constraint(equalToConstant: 20),
            amountPic.widthAnchor.constraint(equalToConstant: 20),
            
            descriptionPic.heightAnchor.constraint(equalToConstant: 20),
            descriptionPic.widthAnchor.constraint(equalToConstant: 20),
            
            frequencyPic.heightAnchor.constraint(equalToConstant: 20),
            frequencyPic.widthAnchor.constraint(equalToConstant: 20),
            
            datePic.heightAnchor.constraint(equalToConstant: 20),
            datePic.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
