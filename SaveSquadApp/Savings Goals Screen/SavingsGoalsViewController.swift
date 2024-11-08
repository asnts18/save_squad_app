import UIKit

class SavingsGoalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateSavingsGoalDelegate {
    
    let savingsGoalsScreen = SavingsGoalsView()
    
    // Arrays to hold current and completed goals
    var currentGoals: [SavingsGoal] = []
    var completedGoals: [SavingsGoal] = []
    
    override func loadView() {
        view = savingsGoalsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the navigation bar to use custom title area
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // TableView setup
        savingsGoalsScreen.tableView.delegate = self
        savingsGoalsScreen.tableView.dataSource = self

        // Add target for the "+" button to navigate to create goal page
        savingsGoalsScreen.addGoalButton.addTarget(self, action: #selector(addGoal), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore navigation bar visibility when leaving the view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation to Create Goal
    @objc func addGoal() {
        let createGoalVC = CreateSavingsGoalViewController()
        createGoalVC.delegate = self
        navigationController?.pushViewController(createGoalVC, animated: true)
    }
    
    // MARK: - CreateSavingsGoalDelegate
    func didCreateGoal(_ goal: SavingsGoal) {
        currentGoals.append(goal)
        savingsGoalsScreen.tableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One for current goals, one for completed goals
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? currentGoals.count : completedGoals.count
    }
    
    // Custom header view for each section to change font size and color
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = section == 0 ? "Current Goals" : "Completed Goals"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        // Constraints to position the label within the header view
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }

    // Set header height for spacing
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Adjust height as needed
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingsGoalCell", for: indexPath) as! SavingsGoalCell
        let goal = indexPath.section == 0 ? currentGoals[indexPath.row] : completedGoals[indexPath.row]
        cell.configure(with: goal)
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGoal = indexPath.section == 0 ? currentGoals[indexPath.row] : completedGoals[indexPath.row]
        let goalDetailVC = GoalDetailViewController(goal: selectedGoal)
        goalDetailVC.delegate = self
        navigationController?.pushViewController(goalDetailVC, animated: true)
    }
}

// MARK: - GoalDetailDelegate
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
