//
//  AddIncomeView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class AddIncomeView: UIView {
    
    var amountStack: UIStackView!
    var amountPic: UIImageView!
    var amountTextField: UITextField!
    var descriptionStack: UIStackView!
    var descriptionPic: UIImageView!
    var descriptionTextField: UITextField!
    var frequencyStack: UIStackView!
    var frequencyPic: UIImageView!
    var frequencyButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupAmountStack()
        setupAmountPic()
        setupAmountTextField()
        setupDescriptionStack()
        setupDescriptionPic()
        setupDescriptionTextField()
        setupFrequencyStack()
        setupFrequencyPic()
        setupFrequencyButton()
        initConstraints()
    }
    
    func setupAmountStack(){
        amountStack = UIStackView()
        amountStack.axis = .horizontal
        amountStack.alignment = .center
        amountStack.distribution = .fillProportionally
        amountStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(amountStack)
    }
    
    func setupAmountPic(){
        amountPic = UIImageView()
        amountPic.image = UIImage(systemName: "dollarsign")?.withRenderingMode(.alwaysOriginal)
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
        self.addSubview(descriptionStack)
    }
    
    func setupDescriptionPic(){
        descriptionPic = UIImageView()
        descriptionPic.image = UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysOriginal)
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
        self.addSubview(frequencyStack)
    }
    
    func setupFrequencyPic(){
        frequencyPic = UIImageView()
        frequencyPic.image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysOriginal)
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
        frequencyButton.setTitle("Select an option", for: .normal)
        frequencyButton.layer.borderWidth = 1
        frequencyButton.layer.borderColor = UIColor.lightGray.cgColor
        frequencyButton.layer.cornerRadius = 5
        frequencyButton.translatesAutoresizingMaskIntoConstraints = false
        frequencyButton.setTitleColor(UIColor.black, for: .normal)
        frequencyStack.addArrangedSubview(frequencyButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            amountStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            amountStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            amountStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            amountStack.heightAnchor.constraint(equalToConstant: 60),
            
            amountTextField.widthAnchor.constraint(equalTo: amountStack.widthAnchor, multiplier: 0.9),
            
            descriptionStack.topAnchor.constraint(equalTo: amountStack.bottomAnchor, constant: 16),
            descriptionStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionStack.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextField.widthAnchor.constraint(equalTo: descriptionStack.widthAnchor, multiplier: 0.9),
            
            frequencyStack.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 16),
            frequencyStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            frequencyStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            frequencyStack.heightAnchor.constraint(equalToConstant: 60),
            
            frequencyButton.widthAnchor.constraint(equalTo: frequencyStack.widthAnchor, multiplier: 0.9),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
