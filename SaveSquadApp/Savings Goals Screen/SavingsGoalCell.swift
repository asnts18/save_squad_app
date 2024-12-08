//
//  SavingsGoalCell.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//
import UIKit

class SavingsGoalCell: UITableViewCell {
    
    let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Utilities.lightPurple
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let goalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTargetAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTargetDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(goalImageView)
        contentView.addSubview(goalNameLabel)
        contentView.addSubview(goalTargetAmountLabel)
        contentView.addSubview(goalTargetDateLabel)
        
        NSLayoutConstraint.activate([
            goalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            goalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalImageView.widthAnchor.constraint(equalToConstant: 50),
            goalImageView.heightAnchor.constraint(equalToConstant: 50),
            
            goalNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            goalNameLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 15),
            goalNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            goalTargetAmountLabel.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 5),
            goalTargetAmountLabel.leadingAnchor.constraint(equalTo: goalNameLabel.leadingAnchor),
            goalTargetAmountLabel.trailingAnchor.constraint(equalTo: goalNameLabel.trailingAnchor),
            
            goalTargetDateLabel.topAnchor.constraint(equalTo: goalTargetAmountLabel.bottomAnchor, constant: 5),
            goalTargetDateLabel.leadingAnchor.constraint(equalTo: goalNameLabel.leadingAnchor),
            goalTargetDateLabel.trailingAnchor.constraint(equalTo: goalNameLabel.trailingAnchor),
            goalTargetDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with goal: SavingsGoal) {
        
        if let imageURLString = goal.imageURL, let imageURL = URL(string: imageURLString) {
            goalImageView.loadRemoteImage(from: imageURL)
        } else {
            goalImageView.image = UIImage(systemName: "photo") // Fallback to default image
        }
        goalNameLabel.text = goal.name
        goalTargetAmountLabel.text = String(format: "$%.2f", goal.cost ?? 0.0)
        goalTargetDateLabel.text = "Target Date: \(goal.targetDateFormatted)"
    }
}

