//
//  LoginView.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/4/24.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Properties
    var contentWrapper: UIScrollView!
    var labelTitle: UILabel!
    var imageLogo: UIImageView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        // set up methods
        setupContentWrapper()
        setupLabelTitle()
        setupImageLogo()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonRegister()
        
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
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "SaveSquad"
        labelTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center
        labelTitle.textColor = UIColor(red: 123/255, green: 87/255, blue: 252/255, alpha: 1) // Hex color #7b57fc
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelTitle)
    }
    
    func setupImageLogo() {
        imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo1x")
        imageLogo.contentMode = .scaleAspectFill
        imageLogo.clipsToBounds = true
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(imageLogo)
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
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .systemBlue
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 5
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonLogin)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = .systemGray
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.layer.cornerRadius = 5
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonRegister)
    }
    
    // MARK: - Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // Title Label constraints
            labelTitle.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            // Image Logo constraints
            imageLogo.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            imageLogo.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: 150),
            imageLogo.heightAnchor.constraint(equalToConstant: 150),

            // Email TextField constraints
            textFieldEmail.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 40),
            textFieldEmail.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 40),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -40),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField constraints
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 40),
            
            // Login Button constraints
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 30),
            buttonLogin.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 40),
            buttonLogin.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -40),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
            // Register Button constraints
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 10),
            buttonRegister.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 40),
            buttonRegister.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -40),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            buttonRegister.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
