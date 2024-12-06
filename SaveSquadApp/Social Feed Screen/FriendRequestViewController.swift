import UIKit
import FirebaseAuth
import FirebaseFirestore

class FriendRequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FriendRequestCellDelegate {
    let tableView = UITableView()
    var friendRequests: [(fromUserID: String, fromEmail: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friend Requests"
        setupTableView()
        fetchFriendRequests()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: "FriendRequestCell")
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func fetchFriendRequests() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(currentUserID).collection("friendRequests").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friend requests: \(error.localizedDescription)")
                return
            }

            self.friendRequests = snapshot?.documents.compactMap { document in
                let fromUserID = document.documentID
                let fromEmail = document.get("fromEmail") as? String ?? "Unknown"
                return (fromUserID, fromEmail)
            } ?? []

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func didAcceptRequest(fromUserID: String) {
        // Accept logic here
    }

    func didDenyRequest(fromUserID: String) {
        // Deny logic here
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestCell", for: indexPath) as! FriendRequestCell
        let request = friendRequests[indexPath.row]
        cell.configure(with: request.fromEmail, fromUserID: request.fromUserID)
        cell.delegate = self
        return cell
    }
}
