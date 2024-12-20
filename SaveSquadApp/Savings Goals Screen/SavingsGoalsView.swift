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
        view.backgroundColor = Utilities.purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        button.backgroundColor = Utilities.purple
        button.tintColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.clipsToBounds = false
        button.imageView?.clipsToBounds = true
        button.layer.cornerRadius = 30
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
        addSubview(tableView)
        addSubview(addGoalButton)
        
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addGoalButton.topAnchor, constant: -20),
            
            addGoalButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addGoalButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addGoalButton.widthAnchor.constraint(equalToConstant: 60),
            addGoalButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
