//
//  AddExpenseViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit
import PhotosUI


class AddExpenseViewController: UIViewController {

    let addExpenseScreen = AddExpenseView()
    
    // delegate to ExpenseLogViewController
    var delegate: ExpenseLogViewController?
    
    // by default "Personal" is selected
    var selectedCategory = "Personal"
    
    // by default "photo" is selected
    var pickedImage = UIImage(systemName: "photo")
    
    override func loadView() {
        view = addExpenseScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Expense"
        
        addExpenseScreen.buttonSelectCategory.menu = getMenuTypes()
        addExpenseScreen.buttonAddExpense.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        addExpenseScreen.buttonCancel.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)

        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: menu for buttonSelectType setup...
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for category in Utilities.categories{
            let menuItem = UIAction(title: category, handler: {(_) in
                                self.selectedCategory = category
                                self.addExpenseScreen.buttonSelectCategory.setTitle(self.selectedCategory, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select Category", children: menuItems)
    }
    
    //MARK: action for tapping buttonAdd..
      @objc func onAddButtonTapped(){
          guard let descriptionText = addExpenseScreen.textFieldDescription.text, !descriptionText.isEmpty else {
              showAlert(message: "Please enter a description")
              return
          }
          
          guard let amountText = addExpenseScreen.textFieldAmount.text, !amountText.isEmpty, let amount = Double(amountText) else {
              showAlert(message: "Please enter a valid amount")
              return
          }
          
//          let dateEntered = addExpenseScreen.dropdownDate.date
          
          let newExpense = Expense(amount: amount, description: descriptionText, category: selectedCategory, image: pickedImage!)
          
          delegate?.delegateOnAddExpense(expense: newExpense)

          // Go to ExpenseLogViewController
          let expenseLogViewController = ExpenseLogViewController()
          self.navigationController?.pushViewController(expenseLogViewController, animated: true)
      }
    
    
    @objc func onCancelButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
