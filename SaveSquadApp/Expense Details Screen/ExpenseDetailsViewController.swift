//
//  ExpenseDetailsViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/25/24.
//

import UIKit

protocol ExpenseDetailDelegate: AnyObject {
    func editExpense(_ expense: Expense)
    func deleteExpense(_ expense: Expense)
}

class ExpenseDetailsViewController: UIViewController {

    let expenseDetailsScreen = ExpenseDetailsView()
    
    weak var delegate: ExpenseDetailDelegate?
    var expense: Expense

    init(expense: Expense) {
        self.expense = expense
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = expenseDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseDetailsScreen.expenseImageView.image = expense.image
        expenseDetailsScreen.labelDescription.text = expense.description
        expenseDetailsScreen.labelCategory.text = "Category: \(expense.category ?? "Personal")"
        expenseDetailsScreen.labelAmount.text = String(format: "Amount: $%.2f", expense.amount ?? 0.00)
        expenseDetailsScreen.labelDate.text = "Date: \(expense.targetDateFormatted)"
//
//        expenseDetailsScreen.buttonEditExpense.addTarget(self, action: #selector(completeGoal), for: .touchUpInside)
        expenseDetailsScreen.buttonDeleteExpense.addTarget(self, action: #selector(deleteExpense), for: .touchUpInside)
    }
    
    @objc func deleteExpense() {
        delegate?.deleteExpense(expense)
        navigationController?.popViewController(animated: true)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
