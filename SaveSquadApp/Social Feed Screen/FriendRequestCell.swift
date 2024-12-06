//
//  FriendRequestCell.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import UIKit

protocol FriendRequestCellDelegate: AnyObject {
    func didAcceptRequest(fromUserID: String)
    func didDenyRequest(fromUserID: String)
}

class FriendRequestCell: UITableViewCell {
    var emailLabel: UILabel!
    var acceptButton: UIButton!
    var denyButton: UIButton!
    var fromUserID: String?

    weak var delegate: FriendRequestCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)

        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.backgroundColor = .systemGreen
        acceptButton.layer.cornerRadius = 8
        acceptButton.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(acceptButton)

        denyButton = UIButton(type: .system)
        denyButton.setTitle("Deny", for: .normal)
        denyButton.setTitleColor(.white, for: .normal)
        denyButton.backgroundColor = .systemRed
        denyButton.layer.cornerRadius = 8
        denyButton.addTarget(self, action: #selector(denyTapped), for: .touchUpInside)
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(denyButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: denyButton.leadingAnchor, constant: -10),
            acceptButton.widthAnchor.constraint(equalToConstant: 80),
            acceptButton.heightAnchor.constraint(equalToConstant: 40),

            denyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            denyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            denyButton.widthAnchor.constraint(equalToConstant: 80),
            denyButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func configure(with email: String, fromUserID: String) {
        emailLabel.text = email
        self.fromUserID = fromUserID
    }

    @objc private func acceptTapped() {
        guard let fromUserID = fromUserID else { return }
        delegate?.didAcceptRequest(fromUserID: fromUserID)
    }

    @objc private func denyTapped() {
        guard let fromUserID = fromUserID else { return }
        delegate?.didDenyRequest(fromUserID: fromUserID)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
