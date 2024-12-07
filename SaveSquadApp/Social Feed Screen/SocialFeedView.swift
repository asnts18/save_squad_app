//
//  SocialFeedView.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import UIKit

class SocialFeedView: UIView {
    var tableView: UITableView!
    var titleBackgroundView: UIView!
    var titleLabel: UILabel!
    var addFriendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupTitleBackgroundView()
        setupTitleLabel()
        setupAddFriendButton()
        setupTableView()
        setupConstraints()
    }

    private func setupTitleBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = Utilities.purple
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Social Feed"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundView.addSubview(titleLabel)
    }

    private func setupAddFriendButton() {
        addFriendButton = UIButton(type: .system)
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.setTitleColor(.white, for: .normal)
        addFriendButton.backgroundColor = Utilities.purple
        addFriendButton.layer.cornerRadius = 10
        addFriendButton.layer.shadowColor = UIColor.black.cgColor
        addFriendButton.layer.shadowOpacity = 0.2
        addFriendButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        addFriendButton.layer.shadowRadius = 4
        addFriendButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addFriendButton)
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FeedCell")
        self.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Background View
            titleBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 150),

            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor, constant: 16), // Moved to the left
            titleLabel.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: -16), // Positioned lower

            // Add Friend Button
            addFriendButton.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor, constant: 15),
            addFriendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addFriendButton.widthAnchor.constraint(equalToConstant: 150),
            addFriendButton.heightAnchor.constraint(equalToConstant: 40),

            // Table View
            tableView.topAnchor.constraint(equalTo: addFriendButton.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
