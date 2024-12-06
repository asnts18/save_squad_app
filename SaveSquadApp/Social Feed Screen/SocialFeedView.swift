//
//  SocialFeedView.swift
//  SaveSquadApp
//
//  Created by indianrenters on 06/12/24.
//

import UIKit

class SocialFeedView: UIView {
    var tableView: UITableView!
    var addFriendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupTableView()
        setupAddFriendButton()
        initConstraints()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FeedCell")
        self.addSubview(tableView)
    }

    func setupAddFriendButton() {
        addFriendButton = UIButton(type: .system)
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.setTitleColor(.white, for: .normal)
        addFriendButton.backgroundColor = Utilities.purple
        addFriendButton.layer.cornerRadius = 10
        addFriendButton.layer.shadowColor = UIColor.black.cgColor
        addFriendButton.layer.shadowOpacity = 0.2
        addFriendButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        addFriendButton.layer.shadowRadius = 4
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addFriendButton)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            addFriendButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            addFriendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addFriendButton.widthAnchor.constraint(equalToConstant: 200),
            addFriendButton.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: addFriendButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
