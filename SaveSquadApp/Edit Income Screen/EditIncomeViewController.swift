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
}
