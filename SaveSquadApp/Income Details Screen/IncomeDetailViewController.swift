//
//  IncomeDetailViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/27/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class IncomeDetailViewController: UIViewController {
    
    var income:Income!
    let incomeDetailsScreen = IncomeDetailsView()
    var currentUser:FirebaseAuth.User?
    let db = Firestore.firestore()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = incomeDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Income Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = Utilities.purple
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let smallTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes
        self.navigationController?.navigationBar.tintColor = .white
        setLabelsText()
        incomeDetailsScreen.buttonDelete.addTarget(self, action: #selector(deleteIncome), for: .touchUpInside)
        incomeDetailsScreen.buttonEdit.addTarget(self, action: #selector(editIncome), for: .touchUpInside)
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForIncomeEdited(notification:)),
                    name: Notification.Name("incomeEdited"),
                    object: nil)
    }

    func setLabelsText() {
        incomeDetailsScreen.labelDescription.text = income.description
        incomeDetailsScreen.labelAmount.text = String(format: "Amount: $%.2f", income.amount)
        incomeDetailsScreen.labelFrequency.text = "Frequency: \(income.frequency)"
        incomeDetailsScreen.labelDate.text = "Date: \(income.incomeDateFormatted)"
    }
    
    @objc func deleteIncome() {
        let alert = UIAlertController(title: "Delete Income", message: "Are you sure you want to delete this income?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.db.collection("users").document(self.currentUser?.uid ?? "")
                .collection("income").document("\(self.income.id ?? "")").delete { error in
                    if let error = error {
                        print("Error deleting document: \(error.localizedDescription)")
                    } else {
                        print("Document successfully deleted")
                    }
                }
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    
    @objc func editIncome() {
        let editIncomeVC = EditIncomeViewController()
        editIncomeVC.income = self.income
        navigationController?.pushViewController(editIncomeVC, animated: true)
    }
    
    @objc func notificationReceivedForIncomeEdited(notification: Notification){
        let editedIncome = notification.object as! Income
        self.income = editedIncome
        setLabelsText()
    }
}
