//
//  GoalDetailView.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//

import UIKit

class GoalDetailView: UIView {
    
    var titleBackgroundView: UIView!
    var contentWrapper: UIScrollView!

    let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let goalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTargetDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let completeGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Complete Goal", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Goal", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundView()
        setupContentWrapper()
        setupView()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.delaysContentTouches = false
        contentWrapper.canCancelContentTouches = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    private func setupView() {
        backgroundColor = .white
        
        let infoStackView = UIStackView(arrangedSubviews: [goalDescriptionLabel, goalCostLabel, goalTargetDateLabel])
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = 10
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStackView = UIStackView(arrangedSubviews: [completeGoalButton, deleteGoalButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentWrapper.addSubview(goalImageView)
        contentWrapper.addSubview(goalNameLabel)
        contentWrapper.addSubview(infoStackView)
        contentWrapper.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            goalImageView.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 20),
            goalImageView.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            goalImageView.widthAnchor.constraint(equalToConstant: 150),
            goalImageView.heightAnchor.constraint(equalToConstant: 150),
            
            goalNameLabel.topAnchor.constraint(equalTo: goalImageView.bottomAnchor, constant: 20),
            goalNameLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            
            buttonStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -20),
            completeGoalButton.heightAnchor.constraint(equalToConstant: 50),
            deleteGoalButton.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
