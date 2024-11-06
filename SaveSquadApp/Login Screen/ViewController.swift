//
//  ViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 10/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let loginScreen = LoginView()
    let registerScreen = RegisterView()
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
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Go right to Tab Bar controller to skip login/test post-login experience
        //Comment these next two lines out if you want to test login/register screens
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

