//
//  EditExpenseViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditExpenseViewController: AddExpenseViewController {
    
    var expense: Expense? // This should be set when this controller is instantiated
    var expenseID: String? // The document ID of the expense to be edited
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Expense"
        
        if let expense = expense {
            // Set initial values from the existing expense
            addExpenseScreen.textfieldDescription.text = expense.description
            addExpenseScreen.textfieldAmount.text = String(format: "%.2f", expense.amount ?? 0.00)
            addExpenseScreen.buttonCategory.setTitle(expense.category, for: .normal)
            addExpenseScreen.pickerDate.date = expense.date
            addExpenseScreen.buttonAddExpense.setTitle("Save Changes", for: .normal)
            if let imageURL = expense.imageURL, let url = URL(string: imageURL) {
                addExpenseScreen.expenseImageView.loadRemoteImage(from: url) // Load image from URL
            }
        }
        
        // Change button target to the edit handler
        addExpenseScreen.buttonAddExpense.removeTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        addExpenseScreen.buttonAddExpense.addTarget(self, action: #selector(onEditButtonTapped), for: .touchUpInside)
    }
    
    @objc func onEditButtonTapped() {
        guard let expenseID = expenseID else {
            print("Error: Expense ID is not set.")
            return
        }
        
        // Get the current user ID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: No user is logged in.")
            return
        }
        
        var description: String = ""
        var amount: Double = 0.0
        
        // Validate description text field input
        if let descriptionText = addExpenseScreen.textfieldDescription.text,
           let amountText = addExpenseScreen.textfieldAmount.text {
            
            if !descriptionText.isEmpty {
                description = descriptionText
            } else {
                showErrorAlert(message: "Please add a description.")
                return
            }
            
            // Validate amount text field input
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
            
            // Upload the image if it exists
            if let image = image {
                pickedImage = image // Assign the picked image to the property used in uploadExpensePhotoToStorage
                uploadExpensePhotoToStorage { [weak self] imageURL in
                    guard let self = self else { return }
                    
                    // Create updatedExpense object with the new image URL
                    let updatedExpense = Expense(amount: amount, description: description, category: self.selectedCategory, date: date, imageURL: imageURL)
                    
                    // Convert to dictionary
                    let updatedExpenseData = updatedExpense.toDictionary()
                    
                    // Update Firestore document
                    self.db.collection("users").document(userID)
                        .collection("expenses").document(expenseID).updateData(updatedExpenseData) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                        } else {
                            print("Document successfully updated")
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
            } else {
                // Create updatedExpense object without changing the image URL
                let updatedExpense = Expense(amount: amount, description: description, category: selectedCategory, date: date, imageURL: expense?.imageURL)
                
                // Convert to dictionary
                let updatedExpenseData = updatedExpense.toDictionary()
                                
                // Update Firestore document
                db.collection("users").document(userID)
                    .collection("expenses").document(expenseID).updateData(updatedExpenseData) { error in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Document successfully updated")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
