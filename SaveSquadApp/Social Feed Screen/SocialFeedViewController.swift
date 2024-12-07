//
//  SocialFeedViewController.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SocialFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let socialScreen = SocialFeedView()
    var milestones: [Milestone] = []
    

    override func loadView() {
        view = socialScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        socialScreen.tableView.dataSource = self
        socialScreen.tableView.delegate = self
        socialScreen.tableView.register(SocialGoalCell.self, forCellReuseIdentifier: "SocialGoalCell")
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

        db.collection("users").document(currentUserID).collection("friends").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friends: \(error.localizedDescription)")
                return
            }

            guard let friends = snapshot?.documents.map({ $0.documentID }) else { return }
            self.milestones = []

            let group = DispatchGroup()

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
                                    let timestamp = document.get("timestamp") as? Timestamp,
                                    let friendEmail = document.get("friendEmail") as? String
                                else {
                                    print("Missing required fields for milestone: \(document.data())")
                                    return nil
                                }

                                let imageURL = document.get("imageURL") as? String
                                print("Fetched Milestone - friendName: \(friendName), text: \(text), imageURL: \(imageURL ?? "No URL")")

                                return Milestone(friendName: friendName, text: text, timestamp: timestamp, friendEmail: friendEmail, imageURL: imageURL)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialGoalCell", for: indexPath) as! SocialGoalCell
        let milestone = milestones[indexPath.row]

        cell.configure(with: SocialGoal(
            userName: milestone.friendName,
            goalName: milestone.text,
            goalDescription: "Achieved a goal!", // Example description
            goalCost: 0.0, // Replace with actual cost if available
            completedDate: milestone.timestamp.dateValue(),
            userEmail: milestone.friendEmail,
            imageURL: nil // Replace with actual image URL if available
        ))

        return cell
    }

}

struct Milestone {
    let friendName: String
    let text: String
    let timestamp: Timestamp
    let friendEmail: String
    let imageURL: String?
}

