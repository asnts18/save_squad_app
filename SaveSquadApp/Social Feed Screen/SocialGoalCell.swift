//
//  SocialGoalCell.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//
import UIKit

class SocialGoalCell: UITableViewCell {
    private let userEmailLabel = UILabel()
    private let goalNameLabel = UILabel()
    private let goalDateLabel = UILabel()
    private let goalImageView = UIImageView()
    private let containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        goalImageView.contentMode = .scaleAspectFill
        goalImageView.layer.cornerRadius = 8
        goalImageView.clipsToBounds = true
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalImageView)

        userEmailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userEmailLabel.textColor = .darkGray
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(userEmailLabel)

        goalNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        goalNameLabel.textColor = .black
        goalNameLabel.numberOfLines = 1
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalNameLabel)

        goalDateLabel.font = UIFont.systemFont(ofSize: 12)
        goalDateLabel.textColor = .gray
        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalDateLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            goalImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            goalImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            goalImageView.widthAnchor.constraint(equalToConstant: 60),
            goalImageView.heightAnchor.constraint(equalToConstant: 60),

            userEmailLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            userEmailLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 10),
            userEmailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            goalNameLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 5),
            goalNameLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            goalNameLabel.trailingAnchor.constraint(equalTo: userEmailLabel.trailingAnchor),

            goalDateLabel.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 5),
            goalDateLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            goalDateLabel.trailingAnchor.constraint(equalTo: userEmailLabel.trailingAnchor),
            goalDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with goal: SocialGoal) {
        userEmailLabel.text = goal.userEmail
        goalNameLabel.text = "Goal Achieved: \(goal.goalName)"
        goalDateLabel.text = DateFormatter.localizedString(from: goal.completedDate, dateStyle: .medium, timeStyle: .short)

        if let imageURL = goal.imageURL, let url = URL(string: imageURL) {
            goalImageView.loadRemoteImage(from: url)
        } else {
            goalImageView.image = UIImage(systemName: "photo") // Placeholder
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
