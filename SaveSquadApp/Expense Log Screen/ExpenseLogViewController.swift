//
//  ExpenseLogViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class ExpenseLogViewController: UIViewController {

    let expenseLogScreen = ExpenseLogView()
    
    override func loadView() {
        view = expenseLogScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expenses"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
