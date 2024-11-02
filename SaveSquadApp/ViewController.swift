//
//  ViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 10/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeScreen = HomeScreenView()
    let addExpenseScreen = AddExpenseView()
    let addIncomeScreen = AddIncomeView()
    let expenseLogScreen = ExpenseLogView()
    let expenseDetailsScreen = ExpenseDetailsView()
    let savingsGoalsScreen = SavingsGoalsView()
    let createSavingsGoalScreen = CreateSavingsGoalView()
    let goalDetailsScreen = GoalDetailsView()
    let socialFeedScreen = SocialFeedView()
    let friendsListScreen = FriendsListView()
    let friendRequestsScreen = FriendRequestsView()
    
    override func loadView() {
        view = friendRequestsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

