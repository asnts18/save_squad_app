//
//  EditExpenseViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditExpenseViewController: AddExpenseViewController {
    
    var expense: Expense

    init(expense: Expense, currentUser: FirebaseAuth.User?) {
        self.expense = expense
        super.init(nibName: nil, bundle: nil)
        self.currentUser = currentUser // Set the currentUser here
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Expense"
        populateExpenseDetails()
    }

    private func populateExpenseDetails() {
        // Populate the fields with the existing expense details
        addExpenseScreen.expenseImageView.image = expense.image
        addExpenseScreen.textfieldAmount.text = String(format: "%.2f", expense.amount ?? 0.00)
        addExpenseScreen.textfieldDescription.text = expense.description
        addExpenseScreen.buttonCategory.setTitle(expense.category ?? "Select Category", for: .normal)
        addExpenseScreen.pickerDate.date = expense.date
        addExpenseScreen.buttonAddExpense.setTitle("Save Changes", for: .normal)
    }

    // Override the onAddButtonTapped to handle updating the expense
    override func onAddButtonTapped() {
        var description:String = ""
        var amount:Double = 0.0

        // validate description text field input
        if let descriptionText = addExpenseScreen.textfieldDescription.text,
           let amountText = addExpenseScreen.textfieldAmount.text {

            if !descriptionText.isEmpty {
                description = descriptionText
            } else {
                showErrorAlert(message: "Please add description.")
                return
            }

            // validate amount text field input
            if !amountText.isEmpty {
                if let uwAmount = Double(amountText) {
                    amount = uwAmount
                } else {
                    showErrorAlert(message: "Please enter a valid amount.")
                    return
                }
            } else {
                showErrorAlert(message: "Please add an amount.")
                return
            }

            let image = addExpenseScreen.expenseImageView.image
            let date = addExpenseScreen.pickerDate.date

            // create updatedExpense object
            let updatedExpense = Expense(amount: amount, description: description, category: selectedCategory, date: date, image: image)

            // convert to dictionary
            let updatedExpenseData = updatedExpense.toDictionary()
            
            // TODO: Delete after. Debugging statements to check values
            print("Updating expense with data: \(updatedExpenseData)")
            
            // Update Firestore with the new data
            db.collection("users").document(self.currentUser?.uid ?? "")
                .collection("expenses").document("\(self.expense.id ?? "")").updateData(updatedExpenseData) { error in
                    if let error = error {
                        self.showErrorAlert(message: "Error updating expense: \(error.localizedDescription)")
                    } else {
                        // post notification to NotificationCenter
                        NotificationCenter.default.post(name: NSNotification.Name("expenseUpdated"), object: updatedExpense)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
        }
    }
}


