//
//  GoalDetailViewController.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//

import UIKit

protocol GoalDetailDelegate: AnyObject {
    func markGoalAsComplete(_ goal: SavingsGoal)
    func deleteGoal(_ goal: SavingsGoal)
}

class GoalDetailViewController: UIViewController {
    
    let goalDetailView = GoalDetailView()
    weak var delegate: GoalDetailDelegate?
    var goal: SavingsGoal

    init(goal: SavingsGoal) {
        self.goal = goal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = goalDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalDetailView.goalImageView.image = goal.image
        goalDetailView.goalNameLabel.text = goal.name
        goalDetailView.goalDescriptionLabel.text = goal.description
        goalDetailView.goalCostLabel.text = String(format: "Cost: $%.2f", goal.cost)
        goalDetailView.goalTargetDateLabel.text = "Target Date: \(goal.targetDateFormatted)"
        
        goalDetailView.completeGoalButton.addTarget(self, action: #selector(completeGoal), for: .touchUpInside)
        goalDetailView.deleteGoalButton.addTarget(self, action: #selector(deleteGoal), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func completeGoal() {
        delegate?.markGoalAsComplete(goal)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteGoal() {
        delegate?.deleteGoal(goal)
        navigationController?.popViewController(animated: true)
    }
}
