//
//  EditIncomeViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/29/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditIncomeViewController: UIViewController {
    
    let editIncomeScreen = EditIncomeView()
    var income: Income!
    var currentUser:FirebaseAuth.User?
    let db = Firestore.firestore()
    var selectedFrequency: String!
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = editIncomeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Income"
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
        populateTextFields()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        setupFrequencyMenu()
        editIncomeScreen.cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        editIncomeScreen.saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            self.currentUser = nil
        }
    }

    func populateTextFields() {
        self.editIncomeScreen.textFieldDescription.text = income.description
        self.editIncomeScreen.textFieldAmount.text = String(income.amount)
        self.editIncomeScreen.buttonFrequency.setTitle("\(income.frequency)", for: .normal)
    }
    
    /*
     Hides the keyboard.
     */
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    func setupFrequencyMenu(){
        var menuItems = [UIAction]()
        for frequency in Utilities.frequencies{
            let menuItem = UIAction(title: frequency, handler: {(_) in
                self.selectedFrequency = frequency
                self.editIncomeScreen.buttonFrequency.setTitle(self.selectedFrequency, for: .normal)
            })
            menuItems.append(menuItem)
        }
        editIncomeScreen.buttonFrequency.menu = UIMenu(title: "Select Frequency", children: menuItems)
        editIncomeScreen.buttonFrequency.showsMenuAsPrimaryAction = true
        editIncomeScreen.datePicker.date = income.incomeDate
    }
    
    @objc func onCancelButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onSaveButtonTapped() {
        var amount: Double = 0.0
        var description: String = ""
        if let amountText = editIncomeScreen.textFieldAmount.text,
           let descriptionText = editIncomeScreen.textFieldDescription.text,
           let frequencyText = editIncomeScreen.buttonFrequency.titleLabel?.text {
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
            //showActivityIndicator()
            let incomeDate = editIncomeScreen.datePicker.date
            let editedIncome = Income(amount: amount, description: description, frequency: self.selectedFrequency, incomeDate: incomeDate)
            let editedIncomeData: [String: Any] = [
                "amount": editedIncome.amount,
                "description": editedIncome.description,
                "frequency": editedIncome.frequency,
                "incomeDate": editedIncome.incomeDate
            ]
            db.collection("users").document(self.currentUser?.uid ?? "")
                .collection("income").document("\(self.income.id ?? "")").updateData(editedIncomeData) { error in
                    if let error = error {
                        print("Error updating completion status: \(error.localizedDescription)")
                    } else {
                        print("Completion status updated successfully!")
                    }
                }
            navigationController?.popViewController(animated: true)
            self.notificationCenter.post(
                name: Notification.Name("incomeEdited"),
                object: editedIncome)
            //self.hideActivityIndicator()
        }
        else{
            self.showErrorAlert(message: "Fields cannot be left empty.")
            //self.hideActivityIndicator()
            return
        }
    }
    
    /*
     Returns a boolean value based on whether the inputted string is a valid amount.
     */
    func isValidAmount(_ amount: String) -> Bool {
        let amountRegEx = "[0-9.]{1,10}"
        let amountPred = NSPredicate(format:"SELF MATCHES %@", amountRegEx)
        return amountPred.evaluate(with: amount)
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
}
