//
//  AddExpenseView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class AddExpenseView: UIView {

    var bottomNavBar:UIView!
    var homeContainer:UIView!
    var homeButton:UIButton!
    var homeLabel:UILabel!
    var expenseLogContainer:UIView!
    var expenseLogButton:UIButton!
    var expenseLogLabel:UILabel!
    var goalsContainer:UIView!
    var goalsButton:UIButton!
    var goalsLabel:UILabel!
    var socialContainer:UIView!
    var socialButton:UIButton!
    var socialLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBottomNavBar()
        setupHomeContainer()
        setupHomeButton()
        setupHomeLabel()
        setupExpenseLogContainer()
        setupExpenseLogButton()
        setupExpenseLogLabel()
        setupGoalsContainer()
        setupGoalsButton()
        setupGoalsLabel()
        setupSocialContainer()
        setupSocialButton()
        setupSocialLabel()
        initConstraints()
    }

    func setupBottomNavBar() {
        bottomNavBar = UIView()
        bottomNavBar.backgroundColor = .white
        bottomNavBar.layer.cornerRadius = 6
        bottomNavBar.layer.shadowColor = UIColor.lightGray.cgColor
        bottomNavBar.layer.shadowOffset = .zero
        bottomNavBar.layer.shadowRadius = 4.0
        bottomNavBar.layer.shadowOpacity = 0.7
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomNavBar)
    }
    
    func setupHomeContainer() {
        homeContainer = UIView()
        homeContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(homeContainer)
    }
    
    func setupHomeButton(){
        homeButton = UIButton(type: .system)
        homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        homeButton.tintColor = .black
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeContainer.addSubview(homeButton)
    }
    
    func setupHomeLabel() {
        homeLabel = UILabel()
        homeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        homeLabel.textAlignment = .center
        homeLabel.text = "Home"
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeContainer.addSubview(homeLabel)
    }
    
    func setupExpenseLogContainer() {
        expenseLogContainer = UIView()
        expenseLogContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(expenseLogContainer)
    }
    
    func setupExpenseLogButton(){
        expenseLogButton = UIButton(type: .system)
        expenseLogButton.setImage(UIImage(systemName: "chart.bar.xaxis"), for: .normal)
        expenseLogButton.tintColor = .black
        expenseLogButton.translatesAutoresizingMaskIntoConstraints = false
        expenseLogContainer.addSubview(expenseLogButton)
    }
    
    func setupExpenseLogLabel() {
        expenseLogLabel = UILabel()
        expenseLogLabel.font = UIFont.boldSystemFont(ofSize: 16)
        expenseLogLabel.textAlignment = .center
        expenseLogLabel.text = "Expenses"
        expenseLogLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseLogContainer.addSubview(expenseLogLabel)
    }
    
    func setupGoalsContainer() {
        goalsContainer = UIView()
        goalsContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(goalsContainer)
    }
    
    func setupGoalsButton(){
        goalsButton = UIButton(type: .system)
        goalsButton.setImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
        goalsButton.tintColor = .black
        goalsButton.translatesAutoresizingMaskIntoConstraints = false
        goalsContainer.addSubview(goalsButton)
    }
    
    func setupGoalsLabel() {
        goalsLabel = UILabel()
        goalsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        goalsLabel.textAlignment = .center
        goalsLabel.text = "Goals"
        goalsLabel.translatesAutoresizingMaskIntoConstraints = false
        goalsContainer.addSubview(goalsLabel)
    }
    
    func setupSocialContainer() {
        socialContainer = UIView()
        socialContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(socialContainer)
    }
    
    func setupSocialButton(){
        socialButton = UIButton(type: .system)
        socialButton.setImage(UIImage(systemName: "person.2"), for: .normal)
        socialButton.tintColor = .black
        socialButton.translatesAutoresizingMaskIntoConstraints = false
        socialContainer.addSubview(socialButton)
    }
    
    func setupSocialLabel() {
        socialLabel = UILabel()
        socialLabel.font = UIFont.boldSystemFont(ofSize: 16)
        socialLabel.textAlignment = .center
        socialLabel.text = "Social"
        socialLabel.translatesAutoresizingMaskIntoConstraints = false
        socialContainer.addSubview(socialLabel)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            bottomNavBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomNavBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomNavBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 80),
            
            homeContainer.leadingAnchor.constraint(equalTo: bottomNavBar.leadingAnchor),
            homeContainer.widthAnchor.constraint(equalTo: bottomNavBar.widthAnchor, multiplier: 0.25),
            homeContainer.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            homeContainer.heightAnchor.constraint(equalTo: bottomNavBar.heightAnchor),
            
            homeButton.centerXAnchor.constraint(equalTo: homeContainer.centerXAnchor),
            homeButton.bottomAnchor.constraint(equalTo: homeLabel.topAnchor, constant: -8),
            homeLabel.centerXAnchor.constraint(equalTo: homeContainer.centerXAnchor),
            homeLabel.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor, constant: -8),
            
            expenseLogContainer.leadingAnchor.constraint(equalTo: homeContainer.trailingAnchor),
            expenseLogContainer.widthAnchor.constraint(equalTo: bottomNavBar.widthAnchor, multiplier: 0.25),
            expenseLogContainer.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            expenseLogContainer.heightAnchor.constraint(equalTo: bottomNavBar.heightAnchor),
            
            expenseLogButton.centerXAnchor.constraint(equalTo: expenseLogContainer.centerXAnchor),
            expenseLogButton.bottomAnchor.constraint(equalTo: expenseLogLabel.topAnchor, constant: -8),
            expenseLogLabel.centerXAnchor.constraint(equalTo: expenseLogContainer.centerXAnchor),
            expenseLogLabel.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor, constant: -8),
            
            goalsContainer.leadingAnchor.constraint(equalTo: expenseLogContainer.trailingAnchor),
            goalsContainer.widthAnchor.constraint(equalTo: bottomNavBar.widthAnchor, multiplier: 0.25),
            goalsContainer.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            goalsContainer.heightAnchor.constraint(equalTo: bottomNavBar.heightAnchor),
            
            goalsButton.centerXAnchor.constraint(equalTo: goalsContainer.centerXAnchor),
            goalsButton.bottomAnchor.constraint(equalTo: goalsLabel.topAnchor, constant: -8),
            goalsLabel.centerXAnchor.constraint(equalTo: goalsContainer.centerXAnchor),
            goalsLabel.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor, constant: -8),
            
            socialContainer.leadingAnchor.constraint(equalTo: goalsContainer.trailingAnchor),
            socialContainer.widthAnchor.constraint(equalTo: bottomNavBar.widthAnchor, multiplier: 0.25),
            socialContainer.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            socialContainer.heightAnchor.constraint(equalTo: bottomNavBar.heightAnchor),
            
            socialButton.centerXAnchor.constraint(equalTo: socialContainer.centerXAnchor),
            socialButton.bottomAnchor.constraint(equalTo: socialLabel.topAnchor, constant: -8),
            socialLabel.centerXAnchor.constraint(equalTo: socialContainer.centerXAnchor),
            socialLabel.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
