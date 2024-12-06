//
//  SocialGoalCell.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//
import UIKit

class SocialGoalCell: UITableViewCell {
    private let userNameLabel = UILabel()
    private let goalDetailsLabel = UILabel()
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

        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .darkGray
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(userNameLabel)

        goalDetailsLabel.font = UIFont.systemFont(ofSize: 14)
        goalDetailsLabel.textColor = .black
        goalDetailsLabel.numberOfLines = 2
        goalDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalDetailsLabel)

        goalDateLabel.font = UIFont.systemFont(ofSize: 12)
        goalDateLabel.textColor = .gray
        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalDateLabel)

        goalImageView.contentMode = .scaleAspectFill
        goalImageView.layer.cornerRadius = 8
        goalImageView.clipsToBounds = true
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goalImageView)
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

            userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            goalDetailsLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            goalDetailsLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            goalDetailsLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),

            goalDateLabel.topAnchor.constraint(equalTo: goalDetailsLabel.bottomAnchor, constant: 5),
            goalDateLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            goalDateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with goal: SocialGoal) {
        userNameLabel.text = goal.userEmail
        goalDetailsLabel.text = "Goal Achieved: \(goal.goalName)"
        goalDateLabel.text = DateFormatter.localizedString(from: goal.completedDate, dateStyle: .medium, timeStyle: .short)

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
