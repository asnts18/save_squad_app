//
//  SavingsGoalsView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class SavingsGoalsView: UIView {

    private let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Goals"
        label.font = UIFont.boldSystemFont(ofSize: 24) // Large font size
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.register(SavingsGoalCell.self, forCellReuseIdentifier: "SavingsGoalCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let addGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.layer.cornerRadius = 25
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
        
        addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        addSubview(tableView)
        addSubview(addGoalButton)
        
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleBackgroundView.centerYAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addGoalButton.topAnchor, constant: -20),
            
            addGoalButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addGoalButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addGoalButton.widthAnchor.constraint(equalToConstant: 50),
            addGoalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
