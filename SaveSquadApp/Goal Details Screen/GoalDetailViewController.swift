//
//  GoalDetailViewController.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//

import UIKit

protocol GoalDetailDelegate: AnyObject {
    func changeCompletionStatus(_ goal: SavingsGoal)
    func deleteGoal(_ goal: SavingsGoal)
}

class GoalDetailViewController: UIViewController {
    
    let goalDetailScreen = GoalDetailView()
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
        view = goalDetailScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Goal Details"

        setLabelsText()
        
        goalDetailScreen.completeGoalButton.addTarget(self, action: #selector(changeCompletionStatus), for: .touchUpInside)
        goalDetailScreen.deleteGoalButton.addTarget(self, action: #selector(deleteGoal), for: .touchUpInside)
        
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
    }
    
    private func setLabelsText() {
        
        if let imageURLString = goal.imageURL, let imageURL = URL(string: imageURLString) {
            goalDetailScreen.goalImageView.loadRemoteImage(from: imageURL) { [weak self] image in
                guard let self = self else { return }
                if let image = image {
                    self.goalDetailScreen.goalImageView.image = image
                }
            }
        } else {
            // Set a placeholder image
            goalDetailScreen.goalImageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        }
        
        goalDetailScreen.goalNameLabel.text = goal.name
        goalDetailScreen.goalDescriptionLabel.text = goal.description
        goalDetailScreen.goalCostLabel.text = String(format: "Cost: $%.2f", goal.cost ?? 0.0)
        goalDetailScreen.goalTargetDateLabel.text = "Target Date: \(goal.targetDateFormatted)"
        if goal.completed {
            goalDetailScreen.completeGoalButton.setTitle("Undo Completion", for: .normal)
        }
    }
    
    // MARK: - Actions
    @objc func changeCompletionStatus() {
        delegate?.changeCompletionStatus(goal)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteGoal() {
        delegate?.deleteGoal(goal)
        navigationController?.popViewController(animated: true)
    }
}
