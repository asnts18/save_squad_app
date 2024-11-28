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
    
    override func loadView() {
        view = incomeDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Income Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
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
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
    }


    func setLabelsText() {
        incomeDetailsScreen.labelDescription.text = income.description
        incomeDetailsScreen.labelAmount.text = String(format: "Amount: $%.2f", income.amount)
        incomeDetailsScreen.labelFrequency.text = "Frequency: \(income.frequency)"
        incomeDetailsScreen.labelDate.text = "Date: \(income.incomeDateFormatted)"
    }
    
    @objc func deleteIncome() {
        db.collection("users").document(self.currentUser?.uid ?? "")
            .collection("income").document("\(income.id ?? "")").delete { error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print("Document successfully deleted")
                }
            }
        navigationController?.popViewController(animated: true)
    }
}