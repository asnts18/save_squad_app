//
//  SavingsGoalsViewController.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class SavingsGoalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateSavingsGoalDelegate {
    
    let savingsGoalsScreen = SavingsGoalsView()
    var currentGoals: [SavingsGoal] = []
    var completedGoals: [SavingsGoal] = []
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = savingsGoalsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        savingsGoalsScreen.tableView.delegate = self
        savingsGoalsScreen.tableView.dataSource = self

        savingsGoalsScreen.addGoalButton.addTarget(self, action: #selector(addGoal), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func addGoal() {
        let createGoalVC = CreateSavingsGoalViewController()
        createGoalVC.delegate = self
        navigationController?.pushViewController(createGoalVC, animated: true)
    }
    
    func didCreateGoal(_ goal: SavingsGoal) {
        let messageData: [String: Any] = [
            "name": goal.name,
            "description": goal.description,
            "cost": goal.cost,
            "targetDate": goal.targetDate,
            "completed": false
        ]
        
        
        db.collection("users").document(self.currentUser?.uid ?? "")
            .collection("goals").addDocument(data: messageData) { error in
            if let error = error {
                print("Error saving message: \(error.localizedDescription)")
            } else {
                print("Message saved successfully!")
                self.currentGoals.append(goal)
                self.savingsGoalsScreen.tableView.reloadData()
            }
        }
    }
    
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
}

extension SavingsGoalsViewController: GoalDetailDelegate {
    
    func markGoalAsComplete(_ goal: SavingsGoal) {
        if let index = currentGoals.firstIndex(where: { $0.name == goal.name }) {
            currentGoals.remove(at: index)
            completedGoals.append(goal)
            savingsGoalsScreen.tableView.reloadData()
        }
    }
    
    func deleteGoal(_ goal: SavingsGoal) {
        if let index = currentGoals.firstIndex(where: { $0.name == goal.name }) {
            currentGoals.remove(at: index)
        } else if let index = completedGoals.firstIndex(where: { $0.name == goal.name }) {
            completedGoals.remove(at: index)
        }
        savingsGoalsScreen.tableView.reloadData()
    }
}
