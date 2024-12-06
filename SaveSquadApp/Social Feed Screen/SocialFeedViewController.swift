//
//  SocialFeedViewController.swift
//  SaveSquadApp
//
//  Created by indianrenters on 06/12/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SocialFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let socialScreen = SocialFeedView()
    var milestones: [Milestone] = [] // Store milestones

    override func loadView() {
        view = socialScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        socialScreen.tableView.dataSource = self
        socialScreen.tableView.delegate = self
        socialScreen.addFriendButton.addTarget(self, action: #selector(navigateToFriendsList), for: .touchUpInside)

        fetchMilestones()
    }

    @objc func navigateToFriendsList() {
        let friendsListVC = FriendsListViewController()
        navigationController?.pushViewController(friendsListVC, animated: true)
    }

    func fetchMilestones() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        // Step 1: Fetch the list of friends
        db.collection("users").document(currentUserID).collection("friends").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friends: \(error.localizedDescription)")
                return
            }

            guard let friends = snapshot?.documents.map({ $0.documentID }) else { return }
            self.milestones = [] // Reset milestones

            let group = DispatchGroup()

            // Step 2: Fetch milestones for each friend
            for friendID in friends {
                group.enter()
                db.collection("users").document(friendID).collection("milestones")
                    .order(by: "timestamp", descending: true)
                    .getDocuments { milestoneSnapshot, milestoneError in
                        if let milestoneError = milestoneError {
                            print("Error fetching milestones: \(milestoneError.localizedDescription)")
                            group.leave()
                        } else {
                            let friendMilestones: [Milestone] = milestoneSnapshot?.documents.compactMap { document in
                                guard
                                    let friendName = document.get("friendName") as? String,
                                    let text = document.get("milestone") as? String,
                                    let timestamp = document.get("timestamp") as? Timestamp
                                else {
                                    return nil
                                }
                                return Milestone(friendName: friendName, text: text, timestamp: timestamp)
                            } ?? []

                            self.milestones.append(contentsOf: friendMilestones)
                            group.leave()
                        }
                    }
            }

            group.notify(queue: .main) {
                self.milestones.sort(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
                self.socialScreen.tableView.reloadData()
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestones.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
        let milestone = milestones[indexPath.row]
        cell.textLabel?.text = "\(milestone.friendName): \(milestone.text)"
        return cell
    }
}

struct Milestone {
    let friendName: String
    let text: String
    let timestamp: Timestamp
}
