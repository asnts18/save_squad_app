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

 // MARK: - FriendRequestCellDelegate Methods
func didAcceptRequest(fromUserID: String) {
    guard let currentUserID = Auth.auth().currentUser?.uid else { return }

    let db = Firestore.firestore()
    let batch = db.batch()

    let currentUserRef = db.collection("users").document(currentUserID).collection("friends").document(fromUserID)
    let senderRef = db.collection("users").document(fromUserID).collection("friends").document(currentUserID)
    let requestRef = db.collection("users").document(currentUserID).collection("friendRequests").document(fromUserID)

    // Add friend relationships and remove the request
    batch.setData(["email": friendRequests.first(where: { $0.fromUserID == fromUserID })?.fromEmail ?? "Unknown"], forDocument: currentUserRef)
    batch.setData(["email": Auth.auth().currentUser?.email ?? "Unknown"], forDocument: senderRef)
    batch.deleteDocument(requestRef)

    batch.commit { error in
        if let error = error {
            print("Error accepting friend request: \(error.localizedDescription)")
        } else {
            print("Friend request accepted!")
            self.fetchFriendRequests() // Refresh the list
        }
    }
}

    func didDenyRequest(fromUserID: String) {
    guard let currentUserID = Auth.auth().currentUser?.uid else { return }

    let db = Firestore.firestore()
    db.collection("users").document(currentUserID).collection("friendRequests").document(fromUserID).delete { error in
        if let error = error {
            print("Error denying friend request: \(error.localizedDescription)")
        } else {
            print("Friend request denied!")
            self.fetchFriendRequests() // Refresh the list
        }
    }
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
