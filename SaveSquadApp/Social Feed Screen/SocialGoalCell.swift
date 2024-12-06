//
//  SocialGoalCell.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import UIKit

class SocialGoalCell: UITableViewCell {
    let userEmailLabel = UILabel()
    let goalNameLabel = UILabel()
    let goalDescriptionLabel = UILabel()
    let goalCostLabel = UILabel()
    let completedDateLabel = UILabel()
    let goalImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        userEmailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        goalNameLabel.font = UIFont.systemFont(ofSize: 14)
        goalDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        goalCostLabel.font = UIFont.systemFont(ofSize: 12)
        completedDateLabel.font = UIFont.systemFont(ofSize: 12)
        goalImageView.contentMode = .scaleAspectFit
        goalImageView.layer.cornerRadius = 8
        goalImageView.clipsToBounds = true

        contentView.addSubview(userEmailLabel)
        contentView.addSubview(goalNameLabel)
        contentView.addSubview(goalDescriptionLabel)
        contentView.addSubview(goalCostLabel)
        contentView.addSubview(completedDateLabel)
        contentView.addSubview(goalImageView)
    }

    private func setupConstraints() {
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        goalDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        goalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        completedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        goalImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            goalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalImageView.widthAnchor.constraint(equalToConstant: 50),
            goalImageView.heightAnchor.constraint(equalToConstant: 50),

            userEmailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userEmailLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 16),
            userEmailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            goalNameLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 4),
            goalNameLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),

            goalDescriptionLabel.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 4),
            goalDescriptionLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),

            goalCostLabel.topAnchor.constraint(equalTo: goalDescriptionLabel.bottomAnchor, constant: 4),
            goalCostLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),

            completedDateLabel.topAnchor.constraint(equalTo: goalCostLabel.bottomAnchor, constant: 4),
            completedDateLabel.leadingAnchor.constraint(equalTo: userEmailLabel.leadingAnchor),
            completedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    func configure(with goal: SocialGoal) {
        userEmailLabel.text = goal.userEmail
        goalNameLabel.text = "Goal: \(goal.goalName)"
        goalDescriptionLabel.text = "Description: \(goal.goalDescription)"
        goalCostLabel.text = "Cost: $\(goal.goalCost)"
        completedDateLabel.text = "Completed: \(DateFormatter.localizedString(from: goal.completedDate, dateStyle: .medium, timeStyle: .short))"

        // Load the image from URL
        if let imageURL = goal.imageURL, let url = URL(string: imageURL) {
            loadImage(from: url)
        } else {
            goalImageView.image = UIImage(systemName: "photo")
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.goalImageView.image = UIImage(data: data)
            }
        }.resume()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
