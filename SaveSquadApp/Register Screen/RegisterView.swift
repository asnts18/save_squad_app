//
//  RegisterView.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/4/24.
//

import UIKit

class RegisterView: UIView {
    
    // MARK: - Properties
    var contentWrapper: UIScrollView!
    var labelRegister: UILabel!  // Label: Register an Account
    var labelEnterInfo: UILabel! // Label: Enter Contact Info
    var textFieldFirstName: UITextField!
    var textFieldLastName: UITextField!
    var textFieldEmail: UITextField!
    var labelCreatePassword: UILabel! // Label: Create Password
    var textFieldPassword: UITextField!
    var textFieldVerifyPassword: UITextField!
    var buttonCreateAccount: UIButton!
    var buttonCancel: UIButton!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        // set up methods
        setupContentWrapper()
        setupLabelRegister()
        setupLabelEnterInfo()
        setupTextFieldFirstName()
        setupTextFieldLastName()
        setupTextFieldEmail()
        setupLabelCreatePassword()
        setupTextFieldPassword()
        setupTextFieldVerifyPassword()
        setupButtonCreateAccount()
        setupButtonCancel()

        // initialize constraints
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.delaysContentTouches = false
        contentWrapper.canCancelContentTouches = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    // MARK: - Setup Methods
    func setupLabelRegister() {
        labelRegister = UILabel()
        labelRegister.text = "Register"
        labelRegister.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        labelRegister.textAlignment = .center
        labelRegister.textColor = UIColor(red: 123/255, green: 87/255, blue: 252/255, alpha: 1) // Hex color #7b57fc
        labelRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelRegister)
    }
    
    func setupLabelEnterInfo() {
        labelEnterInfo = UILabel()
        labelEnterInfo.text = "Enter Contact Info"
        labelEnterInfo.font = UIFont.systemFont(ofSize: 20)
        labelEnterInfo.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEnterInfo)
    }
    
    func setupTextFieldFirstName() {
        textFieldFirstName = UITextField()
        textFieldFirstName.placeholder = "First Name"
        textFieldFirstName.borderStyle = .roundedRect
        textFieldFirstName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldFirstName)
    }
    
    func setupTextFieldLastName() {
        textFieldLastName = UITextField()
        textFieldLastName.placeholder = "Last Name"
        textFieldLastName.borderStyle = .roundedRect
        textFieldLastName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldLastName)
    }

    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldEmail)
    }
    
    func setupLabelCreatePassword() {
        labelCreatePassword = UILabel()
        labelCreatePassword.text = "Create Password"
        labelCreatePassword.font = UIFont.systemFont(ofSize: 20)
        labelCreatePassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelCreatePassword)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupTextFieldVerifyPassword() {
        textFieldVerifyPassword = UITextField()
        textFieldVerifyPassword.placeholder = "Verify Password"
        textFieldVerifyPassword.borderStyle = .roundedRect
        textFieldVerifyPassword.isSecureTextEntry = true
        textFieldVerifyPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldVerifyPassword)
    }
    
    func setupButtonCreateAccount() {
        buttonCreateAccount = UIButton(type: .system)
        buttonCreateAccount.setTitle("Create Account", for: .normal)
        buttonCreateAccount.backgroundColor = .systemBlue
        buttonCreateAccount.setTitleColor(.white, for: .normal)
        buttonCreateAccount.layer.cornerRadius = 5
        buttonCreateAccount.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonCreateAccount)
    }
    
    func setupButtonCancel() {
        buttonCancel = UIButton(type: .system)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.backgroundColor = .systemGray
        buttonCancel.setTitleColor(.white, for: .normal)
        buttonCancel.layer.cornerRadius = 5
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonCancel)
    }
    
    // MARK: - Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // Label Register constraints
            labelRegister.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 20),
            labelRegister.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            labelRegister.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            // Label Enter Info constraints
            labelEnterInfo.topAnchor.constraint(equalTo: labelRegister.bottomAnchor, constant: 20),
            labelEnterInfo.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            labelEnterInfo.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            // First Name TextField constraints
            textFieldFirstName.topAnchor.constraint(equalTo: labelEnterInfo.bottomAnchor, constant: 20),
            textFieldFirstName.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            textFieldFirstName.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor, constant: -10),
            textFieldFirstName.heightAnchor.constraint(equalToConstant: 40),
            
            // Last Name TextField constraints
            textFieldLastName.topAnchor.constraint(equalTo: textFieldFirstName.topAnchor),
            textFieldLastName.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor, constant: 10),
            textFieldLastName.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            textFieldLastName.heightAnchor.constraint(equalToConstant: 40),
            
            // Email TextField constraints
            textFieldEmail.topAnchor.constraint(equalTo: textFieldFirstName.bottomAnchor, constant: 20),
            textFieldEmail.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 40),
            
            // Label Create Password constraints
            labelCreatePassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 40),
            labelCreatePassword.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            labelCreatePassword.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            // Password TextField constraints
            textFieldPassword.topAnchor.constraint(equalTo: labelCreatePassword.bottomAnchor, constant: 20),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 40),
            
            // Verify Password TextField constraints
            textFieldVerifyPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            textFieldVerifyPassword.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            textFieldVerifyPassword.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            textFieldVerifyPassword.heightAnchor.constraint(equalToConstant: 40),
            
            // Create Account Button constraints
            buttonCreateAccount.topAnchor.constraint(equalTo: textFieldVerifyPassword.bottomAnchor, constant: 30),
            buttonCreateAccount.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            buttonCreateAccount.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            buttonCreateAccount.heightAnchor.constraint(equalToConstant: 50),
            
            // Cancel Button constraints
            buttonCancel.topAnchor.constraint(equalTo: buttonCreateAccount.bottomAnchor, constant: 10),
            buttonCancel.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            buttonCancel.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50),
            buttonCancel.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -40),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
