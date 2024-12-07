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
    private let wrapperView = UITableViewCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        // Set up wrapperView for shadow and rounded corners
        wrapperView.layer.cornerRadius = 6.0
        wrapperView.layer.shadowColor = UIColor.gray.cgColor
        wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperView.layer.shadowRadius = 4
        wrapperView.layer.shadowOpacity = 0.2
        wrapperView.layer.masksToBounds = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.backgroundColor = .white
        self.addSubview(wrapperView)

        // Goal image setup
        goalImageView.contentMode = .scaleAspectFill
        goalImageView.layer.cornerRadius = 8
        goalImageView.clipsToBounds = true
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalImageView)

        // User email label setup
        userEmailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userEmailLabel.textColor = .darkGray
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(userEmailLabel)

        // Goal name label setup
        goalNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        goalNameLabel.textColor = .black
        goalNameLabel.numberOfLines = 1
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalNameLabel)

        // Goal date label setup
        goalDateLabel.font = UIFont.systemFont(ofSize: 12)
        goalDateLabel.textColor = .gray
        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalDateLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            goalImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            goalImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            goalImageView.widthAnchor.constraint(equalToConstant: 60),
            goalImageView.heightAnchor.constraint(equalToConstant: 60),

            userEmailLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            userEmailLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 10),
            userEmailLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),

            goalNameLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 5),
            goalNameLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            goalNameLabel.trailingAnchor.constraint(equalTo: userEmailLabel.trailingAnchor),

            goalDateLabel.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 5),
            goalDateLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            goalDateLabel.trailingAnchor.constraint(equalTo: userEmailLabel.trailingAnchor),
            goalDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: wrapperView.bottomAnchor, constant: -10)
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
