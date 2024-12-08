//
//  SocialGoalCell.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//
import UIKit

class SocialGoalCell: UITableViewCell {
    private let userNameLabel = UILabel()
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
        wrapperView.layer.cornerRadius = 6.0
        wrapperView.layer.shadowColor = UIColor.gray.cgColor
        wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperView.layer.shadowRadius = 4
        wrapperView.layer.shadowOpacity = 0.2
        wrapperView.backgroundColor = .white
        wrapperView.layer.borderColor = UIColor.lightGray.cgColor
        wrapperView.clipsToBounds = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperView)

        goalImageView.contentMode = .scaleAspectFill
        goalImageView.layer.cornerRadius = 8
        goalImageView.clipsToBounds = true
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalImageView)

        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .darkGray
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(userNameLabel)

        goalNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        goalNameLabel.textColor = .black
        goalNameLabel.numberOfLines = 1
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalNameLabel)

        goalDateLabel.font = UIFont.systemFont(ofSize: 12)
        goalDateLabel.textColor = .gray
        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(goalDateLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            goalImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            goalImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            goalImageView.widthAnchor.constraint(equalToConstant: 60),
            goalImageView.heightAnchor.constraint(equalToConstant: 60),

            userNameLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: goalImageView.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),

            goalNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            goalNameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            goalNameLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),

            goalDateLabel.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 5),
            goalDateLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            goalDateLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            goalDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: wrapperView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with goal: SocialGoal) {
        userNameLabel.text = "\(goal.userName) achieved their goal!"
        goalNameLabel.text = "\(goal.goalName)"
        goalDateLabel.text = DateFormatter.localizedString(from: goal.completedDate, dateStyle: .medium, timeStyle: .short)

        if let imageURL = goal.imageURL, let url = URL(string: imageURL) {
            goalImageView.loadRemoteImage(from: url) { [weak self] image in
                guard let self = self else { return }
                if let image = image {
                    self.goalImageView.image = image
                }
            }
        } else {
            goalImageView.image = UIImage(systemName: "photo") // Placeholder
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
