//
//  AddIncomeViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddIncomeViewController: UIViewController {

    let addIncomeScreen = AddIncomeView()
    var selectedFrequency = "Select Frequency"
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = addIncomeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Income"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white
        setupFrequencyMenu()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        addIncomeScreen.cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        addIncomeScreen.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
    }

    func setupFrequencyMenu(){
        var menuItems = [UIAction]()
        for frequency in Utilities.frequencies{
            let menuItem = UIAction(title: frequency, handler: {(_) in
                self.selectedFrequency = frequency
                self.addIncomeScreen.frequencyButton.setTitle(self.selectedFrequency, for: .normal)
            })
            menuItems.append(menuItem)
        }
        addIncomeScreen.frequencyButton.menu = UIMenu(title: "Select Frequency", children: menuItems)
        addIncomeScreen.frequencyButton.showsMenuAsPrimaryAction = true
    }
    
    /*
     Hides the keyboard.
     */
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onCancelButtonTapped(){
        navigationController?.popViewController(animated: true)
    }

    @objc func onAddButtonTapped() {
        var amount: Double = 0.0
        var description: String = ""
        if let amountText = addIncomeScreen.amountTextField.text,
           let descriptionText = addIncomeScreen.descriptionTextField.text,
           let frequencyText = addIncomeScreen.frequencyButton.titleLabel?.text {
            if !amountText.isEmpty{
                if !isValidAmount(amountText) {
                    showErrorAlert(message: "Please enter a proper numerical value for the Amount.")
                    return
                }
                if let uw_amount = Double(amountText) {
                    amount = uw_amount
                }
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            if !descriptionText.isEmpty{
                description = descriptionText
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            if !(frequencyText == "Select Frequency"){
                self.selectedFrequency = frequencyText
            } else {
                self.showErrorAlert(message: "You must choose a frequency.")
                return
            }
            let incomeDate = addIncomeScreen.datePicker.date
            let newIncome = Income(amount: amount, description: description, frequency: self.selectedFrequency, incomeDate: incomeDate)
            let createdIncomeData: [String: Any] = [
                "amount": newIncome.amount,
                "description": newIncome.description,
                "frequency": newIncome.frequency,
                "incomeDate": newIncome.incomeDate
            ]
            db.collection("users").document(self.currentUser?.uid ?? "")
                .collection("income").addDocument(data: createdIncomeData) { error in
                if let error = error {
                    print("Error saving message: \(error.localizedDescription)")
                } else {
                    print("Income saved successfully!")
                }
            }
            navigationController?.popViewController(animated: true)
        }
        else{
            self.showErrorAlert(message: "Fields cannot be left empty.")
            return
        }
    }
    
    /*
     Shows appropriate error alert depending on the message value that is inputted.
     */
    func showErrorAlert(message:String){
        let alert = UIAlertController(
                title: "Error!", message: message,
                preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    /*
     Returns a boolean value based on whether the inputted string is a valid amount.
     */
    func isValidAmount(_ amount: String) -> Bool {
        let amountRegEx = "[0-9.]{1,10}"
        let amountPred = NSPredicate(format:"SELF MATCHES %@", amountRegEx)
        return amountPred.evaluate(with: amount)
    }
}
