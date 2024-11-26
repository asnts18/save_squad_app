//
//  IncomeLogViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import UIKit

class IncomeLogViewController: UIViewController {
    let incomeLogScreen = IncomeLogView()
    var oneTimeIncomes: [Income] = []
    var recurringIncomes: [Income] = []
    
    override func loadView() {
        view = incomeLogScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Income"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white
        incomeLogScreen.tableViewIncome.delegate = self
        incomeLogScreen.tableViewIncome.dataSource = self
        incomeLogScreen.tableViewIncome.separatorStyle = .none
    }
}
