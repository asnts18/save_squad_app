//
//  SavingsGoalsViewController.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class SavingsGoalsViewController: UIViewController {

    let savingsGoalsScreen = SavingsGoalsView()
    var currentGoals: [SavingsGoal] = []
    var completedGoals: [SavingsGoal] = []
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = savingsGoalsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                self.currentUser = nil
                let loginViewController = ViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                            
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let window = windowScene.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            }else{
                self.currentUser = user
                self.db.collection("users")
                    .document((self.currentUser?.uid ?? ""))
                    .collection("goals")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.currentGoals.removeAll()
                            self.completedGoals.removeAll()
                            for document in documents{
                                if let completed = document.get("completed") as? Bool {
                                    if completed == false {
                                        do{
                                            let goal = try document.data(as: SavingsGoal.self)
                                            self.currentGoals.append(goal)
                                        }catch{
                                            print(error)
                                        }
                                    } else {
                                        do{
                                            let goal = try document.data(as: SavingsGoal.self)
                                            self.completedGoals.append(goal)
                                        }catch{
                                            print(error)
                                        }
                                    }
                                }
                            }
                            self.currentGoals.sort(by: {$0.targetDate < $1.targetDate})
                            self.completedGoals.sort(by: {$0.targetDate < $1.targetDate})
                            self.savingsGoalsScreen.tableView.reloadData()
                        }
                    })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Goals"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = Utilities.purple
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let smallTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes
        self.navigationController?.navigationBar.tintColor = .white
        savingsGoalsScreen.tableView.delegate = self
        savingsGoalsScreen.tableView.dataSource = self

        savingsGoalsScreen.addGoalButton.addTarget(self, action: #selector(addGoal), for: .touchUpInside)
        
        // Add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNewGoal(_:)), name: NSNotification.Name("NewGoalAdded"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func addGoal() {
        let createGoalVC = CreateSavingsGoalViewController()
        navigationController?.pushViewController(createGoalVC, animated: true)
    }
    
    // MARK: Add new goal to Firestore
    @objc func didReceiveNewGoal(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let newGoal = userInfo["newGoal"] as? SavingsGoal, // Access SavingsGoal object
              let newGoalData = userInfo["newGoalData"] as? [String: Any] else {
            return
        }

        // Print for debugging purposes
        print("New Savings Goal Object: \(newGoal)")
        print("New Savings Goal  Data Dictionary: \(newGoalData)")

        // Save the expense to Firestore using the newExpenseData dictionary
        guard let userID = self.currentUser?.uid else { return }
        db.collection("users").document(userID)
            .collection("goals").addDocument(data: newGoalData) { error in
                if let error = error {
                    print("Error saving goal: \(error.localizedDescription)")
                } else {
                    print("Savings goal saved successfully!")
                }
            }
        hideActivityIndicator()
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NewGoalAdded"), object: nil)
    }
    
}

extension SavingsGoalsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? currentGoals.count : completedGoals.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = section == 0 ? "Current Goals" : "Completed Goals"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingsGoalCell", for: indexPath) as! SavingsGoalCell
        let goal = indexPath.section == 0 ? currentGoals[indexPath.row] : completedGoals[indexPath.row]
        cell.configure(with: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGoal = indexPath.section == 0 ? currentGoals[indexPath.row] : completedGoals[indexPath.row]
        let goalDetailVC = GoalDetailViewController(goal: selectedGoal)
        goalDetailVC.delegate = self
        navigationController?.pushViewController(goalDetailVC, animated: true)
    }
    
    func deleteAllMilestones(completion: @escaping (Error?) -> Void) {
        let userID = self.currentUser?.uid ?? ""
        db.collection("users").document(userID).collection("milestones").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching milestones: \(error.localizedDescription)")
                completion(error)
                return
            }
            guard let documents = snapshot?.documents else {
                print("No milestones to delete.")
                completion(nil)
                return
            }
            let group = DispatchGroup()
            for document in documents {
                group.enter()
                document.reference.delete { error in
                    if let error = error {
                        print("Error deleting document \(document.documentID): \(error.localizedDescription)")
                    } else {
                        print("Document \(document.documentID) successfully deleted.")
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                completion(nil)
            }
        }
    }
    
    
}

extension SavingsGoalsViewController: GoalDetailDelegate {
    
    func changeCompletionStatus(_ goal: SavingsGoal) {
            let completed = goal.completed
            let userEmail = self.currentUser?.email ?? "Unknown User"
            let userID = self.currentUser?.uid ?? ""
            let userName = self.currentUser?.displayName ?? ""
            let db = Firestore.firestore()

            db.collection("users").document(userID)
                .collection("goals").document("\(goal.id ?? "")").updateData([
                    "completed": !completed
                ]) { error in
                    if let error = error {
                        print("Error updating completion status: \(error.localizedDescription)")
                    } else {
                        print("Completion status updated successfully!")
                        self.deleteAllMilestones { error in
                            if let error = error {
                                print("Error deleting milestones: \(error.localizedDescription)")
                                return
                            }
                            print("All milestones deleted successfully!")
                            for completedGoal in self.completedGoals {
                                let milestoneData: [String: Any] = [
                                    "friendName": userName,
                                    "milestone": "\(completedGoal.name ?? "Unnamed Goal")",
                                    "timestamp": Timestamp(date: Date()),
                                    "friendEmail": userEmail,
                                    "imageURL": completedGoal.imageURL ?? ""
                                ]
                                
                                print("Adding to milestone collection: ")
                                print(milestoneData) // debug print
                                
                                db.collection("users").document(userID).collection("milestones")
                                    .addDocument(data: milestoneData) { error in
                                        if let error = error {
                                            print("Error adding milestone: \(error.localizedDescription)")
                                        } else {
                                            print("Milestone added successfully!")
                                        }
                                    }
                            }
                        }
                    }
                }
        }
    
    func deleteGoal(_ goal: SavingsGoal) {
        let alert = UIAlertController(title: "Delete Goal", message: "Are you sure you want to delete this goal?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.db.collection("users").document(self.currentUser?.uid ?? "")
                .collection("goals").document("\(goal.id ?? "")").delete { error in
                    if let error = error {
                        print("Error deleting document: \(error.localizedDescription)")
                    } else {
                        print("Document successfully deleted")
                    }
                }
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
