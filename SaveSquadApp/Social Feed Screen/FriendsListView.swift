//
//  FriendsListView.swift
//  SaveSquadApp
//
//  Created by indianrenters on 06/12/24.
//

import UIKit

class FriendsListView: UIView {
    var searchTextField: UITextField!
    var addFriendButton: UIButton!
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSearchTextField()
        setupAddFriendButton()
        setupTableView()
        initConstraints()
    }

    func setupSearchTextField() {
        searchTextField = UITextField()
        searchTextField.placeholder = "Enter email to add friend"
        searchTextField.borderStyle = .roundedRect
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchTextField)
    }

    func setupAddFriendButton() {
        addFriendButton = UIButton(type: .system)
        addFriendButton.setTitle("Add", for: .normal)
        addFriendButton.setTitleColor(.white, for: .normal)
        addFriendButton.backgroundColor = Utilities.purple
        addFriendButton.layer.cornerRadius = 5
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addFriendButton)
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
        self.addSubview(tableView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: addFriendButton.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addFriendButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            addFriendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addFriendButton.widthAnchor.constraint(equalToConstant: 80),
            addFriendButton.heightAnchor.constraint(equalToConstant: 40),

            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
