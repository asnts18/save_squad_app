//
//  ExpenseDetailsViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/25/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol ExpenseDetailDelegate: AnyObject {
    func editExpense(_ expense: Expense)
    func deleteExpense(_ expense: Expense)
}

class ExpenseDetailsViewController: UIViewController {

    let expenseDetailsScreen = ExpenseDetailsView()
    
    var currentUser:FirebaseAuth.User?
    let db = Firestore.firestore()
    let notificationCenter = NotificationCenter.default
    
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
        title = "Expense Details"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = Utilities.purple
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white

        // set up labels
        setLabelsText()
        
        // add targets to buttons
        expenseDetailsScreen.buttonEditExpense.addTarget(self, action: #selector(editExpenseButtonTapped), for: .touchUpInside)
        expenseDetailsScreen.buttonDeleteExpense.addTarget(self, action: #selector(deleteExpenseButtonTapped), for: .touchUpInside)
        
        // get current user
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
        
        // notification center
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForExpenseEdited(notification:)),
                    name: Notification.Name("expenseUpdated"),
                    object: nil)
    }
    
    private func setLabelsText() {
        expenseDetailsScreen.expenseImageView.image = expense.image
        expenseDetailsScreen.labelDescription.text = expense.description
        expenseDetailsScreen.labelCategory.text = "Category: \(expense.category ?? "Personal")"
        expenseDetailsScreen.labelAmount.text = String(format: "Amount: $%.2f", expense.amount ?? 0.00)
        expenseDetailsScreen.labelDate.text = "Date: \(expense.targetDateFormatted)"
    }
    
    @objc func editExpenseButtonTapped() {
        let editExpenseVC = EditExpenseViewController(expense: self.expense, currentUser: self.currentUser)
        editExpenseVC.expense = self.expense
        navigationController?.pushViewController(editExpenseVC, animated: true)
    }
    
    @objc func deleteExpenseButtonTapped() {
        delegate?.deleteExpense(expense)
        navigationController?.popViewController(animated: true)
    }
        
    
    @objc func notificationReceivedForExpenseEdited(notification: Notification){
        let editedExpense = notification.object as! Expense
        self.expense = editedExpense
        setLabelsText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
