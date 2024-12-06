//
//  FriendsListView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/2/24.
//

import UIKit

class FriendsListView: UIView {
    var tableView: UITableView!
    var addFriendButton: UIButton!
    var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }

    func setupView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
        self.addSubview(tableView)

        textField = UITextField()
        textField.placeholder = "Enter username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)

        addFriendButton = UIButton(type: .system)
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addFriendButton)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 40),

            addFriendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            addFriendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: addFriendButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
