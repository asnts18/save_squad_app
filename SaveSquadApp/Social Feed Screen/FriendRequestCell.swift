import UIKit

protocol FriendRequestCellDelegate: AnyObject {
    func didAcceptRequest(fromUserID: String)
    func didDenyRequest(fromUserID: String)
}

class FriendRequestCell: UITableViewCell {
    weak var delegate: FriendRequestCellDelegate?

    var fromUserID: String?

    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Accept", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let denyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Deny", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(emailLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(denyButton)

        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            denyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            denyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            denyButton.widthAnchor.constraint(equalToConstant: 70),
            denyButton.heightAnchor.constraint(equalToConstant: 30),

            acceptButton.trailingAnchor.constraint(equalTo: denyButton.leadingAnchor, constant: -10),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 70),
            acceptButton.heightAnchor.constraint(equalToConstant: 30),
        ])

        acceptButton.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyTapped), for: .touchUpInside)
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
}
