//
//  FriendsListViewController.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let friendsListView = FriendsListView()
    var friends: [Friend] = []
    let db = Firestore.firestore()
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = friendsListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends List"
        setupToolbar()
        setupView()
        fetchFriends()
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForFriendAdded(notification:)),
            name: Notification.Name("friendAdded"),
            object: nil)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupView() {
        friendsListView.tableView.dataSource = self
        friendsListView.tableView.delegate = self
        friendsListView.addFriendButton.addTarget(self, action: #selector(addFriendTapped), for: .touchUpInside)
    }
    
    private func setupToolbar() {
            let friendRequestsButton = UIBarButtonItem(
                image: UIImage(systemName: "person.crop.circle.badge.plus"),
                style: .plain,
                target: self,
                action: #selector(friendRequestsTapped)
            )
            friendRequestsButton.tintColor = .purple
            navigationItem.rightBarButtonItem = friendRequestsButton
        }
    @objc private func friendRequestsTapped() {
            let friendRequestsVC = FriendRequestsViewController()
            navigationController?.pushViewController(friendRequestsVC, animated: true)
        }
    
    // MARK: - Fetch Friends
    func fetchFriends() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(currentUserID).collection("friends").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friends: \(error.localizedDescription)")
                return
            }

            self.friends = snapshot?.documents.compactMap { document in
                let friendID = document.documentID
                let friendEmail = document.get("email") as? String ?? "Unknown"
                return Friend(id: friendID, email: friendEmail)
            } ?? []

            DispatchQueue.main.async {
                self.friendsListView.tableView.reloadData()
            }
        }
    }

    // MARK: - Add Friend
    @objc func addFriendTapped() {
        guard let email = friendsListView.searchTextField.text?.lowercased(), !email.isEmpty else {
            showAlert(title: "Error", message: "Please enter a valid email.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(title: "Error", message: "Please enter a valid email.")
            return
        }
        
        
        // Check if the email is already in the friends list
        if friends.contains(where: { $0.email.lowercased() == email }) {
            showAlert(title: "Error", message: "You're already friends with this user.")
            return
        }

        // Search for the user in Firebase by email
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error searching for user: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "An error occurred. Please try again.")
                return
            }

            guard let documents = snapshot?.documents, let document = documents.first else {
                self.showAlert(title: "Error", message: "User not found.")
                return
            }

            let recipientID = document.documentID
            if (recipientID == Auth.auth().currentUser?.uid) {
                self.showAlert(title: "Error", message: "You cannot add yourself as a friend.")
                return
            }
            self.sendFriendRequest(to: recipientID, recipientEmail: email)
        }
    }

    func sendFriendRequest(to recipientID: String, recipientEmail: String) {
        guard let currentUserID = Auth.auth().currentUser?.uid,
              let currentUserEmail = Auth.auth().currentUser?.email else { return }

        let friendRequest = [
            "fromUserID": currentUserID,
            "fromEmail": currentUserEmail
        ]

        db.collection("users").document(recipientID).collection("friendRequests").document(currentUserID).setData(friendRequest) { error in
            if let error = error {
                print("Error sending friend request: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Could not send friend request.")
            } else {
                self.showAlert(title: "Success", message: "Friend request sent to \(recipientEmail).")
            }
        }
    }

    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.email
        return cell
    }

    // MARK: - Helper
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func notificationReceivedForFriendAdded(notification: Notification){
        fetchFriends()
    }
    
    /*
     Returns boolean value based on whether the inputted string is a valid email address.
     Code borrowed from https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift/25471164#25471164
     */
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /*
     Hides the keyboard.
     */
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}

// MARK: - Friend Model
struct Friend {
    let id: String
    let email: String
}
