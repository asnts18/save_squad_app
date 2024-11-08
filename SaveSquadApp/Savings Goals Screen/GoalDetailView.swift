//
//  GoalDetailView.swift
//  SaveSquadApp
//
//  Created by Bubesh Dev on 11/7/24.
//

import UIKit

class GoalDetailView: UIView {
    
    // Goal image
    let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Goal name label
    let goalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Goal description label
    let goalDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Goal cost label
    let goalCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Goal target date label
    let goalTargetDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Complete goal button
    let completeGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Complete Goal", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Delete goal button
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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        // Stack view for labels (description, cost, and date)
        let infoStackView = UIStackView(arrangedSubviews: [goalDescriptionLabel, goalCostLabel, goalTargetDateLabel])
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = 10
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack view for buttons
        let buttonStackView = UIStackView(arrangedSubviews: [completeGoalButton, deleteGoalButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(goalImageView)
        addSubview(goalNameLabel)
        addSubview(infoStackView)
        addSubview(buttonStackView)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Goal Image
            goalImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            goalImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            goalImageView.widthAnchor.constraint(equalToConstant: 150),
            goalImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // Goal Name
            goalNameLabel.topAnchor.constraint(equalTo: goalImageView.bottomAnchor, constant: 20),
            goalNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Info Stack View (description, cost, and date)
            infoStackView.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Buttons Stack View
            buttonStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            completeGoalButton.heightAnchor.constraint(equalToConstant: 50),
            deleteGoalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
