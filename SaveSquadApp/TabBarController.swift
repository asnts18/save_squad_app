//
//  TabBarController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = .black                      // Selected color
        tabBar.unselectedItemTintColor = .gray
        let homeTab = UINavigationController(rootViewController: HomeScreenViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "house.fill")
        )
        homeTab.tabBarItem = tabHomeBarItem
        homeTab.title = "Home"
        let tabExpenses = UINavigationController(rootViewController: ExpenseLogViewController())
        let tabExpensesBarItem = UITabBarItem(
            title: "Expenses",
            image: UIImage(systemName: "chart.bar")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "chart.bar.fill")
        )
        tabExpenses.tabBarItem = tabExpensesBarItem
        tabExpenses.title = "Expenses"
        let tabGoals = UINavigationController(rootViewController: SavingsGoalsViewController())
        let tabGoalsBarItem = UITabBarItem(
            title: "Goals",
            image: UIImage(systemName: "dollarsign.circle")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "dollarsign.circle.fill")
        )
        tabGoals.tabBarItem = tabGoalsBarItem
        tabGoals.title = "Goals"
        let tabSocial = UINavigationController(rootViewController: SocialFeedViewController())
        let tabSocialBarItem = UITabBarItem(
            title: "Social",
            image: UIImage(systemName: "person.2")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        tabSocial.tabBarItem = tabSocialBarItem
        tabSocial.title = "Social"
        self.viewControllers = [homeTab, tabExpenses, tabGoals, tabSocial]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
