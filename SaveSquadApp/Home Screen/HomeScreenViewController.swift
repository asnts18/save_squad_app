//
//  HomeScreenViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let homeScreen = HomeScreenView()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        homeScreen.floatingButtonAdd.showsMenuAsPrimaryAction = true
        homeScreen.floatingButtonAdd.menu = UIMenu(title: "",
                                                   children: [
                                                    UIAction(title: "Add Income",handler: {(_) in
                                                        let addIncomeViewController = AddIncomeViewController()
                                                        self.navigationController?.pushViewController(addIncomeViewController, animated: true)
                                                    }),
                                                    UIAction(title: "Add Expense",handler: {(_) in
                                                        let addExpenseViewController = AddExpenseViewController()
                                                        addExpenseViewController.delegate = ExpenseLogViewController()
                                                        self.navigationController?.pushViewController(addExpenseViewController, animated: true)
                                                    })
                                                   ])
    }
}
