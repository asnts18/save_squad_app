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
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white
    }

}
