//
//  HomeScreenView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit

class HomeScreenView: UIView {
    
    var bottomNavBar:UIView!
    var homeContainer:UIView!
    var homeButton:UIButton!
    var homeLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBottomNavBar()
        setupHomeContainer()
        setupHomeButton()
        setupHomeLabel()
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

    func initConstraints(){
        NSLayoutConstraint.activate([
            bottomNavBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomNavBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomNavBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 80),
            
            homeContainer.widthAnchor.constraint(equalTo: bottomNavBar.widthAnchor, multiplier: 0.25),
            homeContainer.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            homeContainer.heightAnchor.constraint(equalTo: bottomNavBar.heightAnchor),
            
            homeButton.centerXAnchor.constraint(equalTo: homeContainer.centerXAnchor),
            homeButton.bottomAnchor.constraint(equalTo: homeLabel.topAnchor, constant: -8),
            homeLabel.centerXAnchor.constraint(equalTo: homeContainer.centerXAnchor),
            homeLabel.bottomAnchor.constraint(equalTo: bottomNavBar.bottomAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
