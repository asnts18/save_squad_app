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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
}
