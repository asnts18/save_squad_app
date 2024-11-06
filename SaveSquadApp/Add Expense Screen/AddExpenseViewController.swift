//
//  AddExpenseViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class AddExpenseViewController: UIViewController {

    let addExpenseScreen = AddExpenseView()
    
    override func loadView() {
        view = addExpenseScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Expense"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
