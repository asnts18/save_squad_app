//
//  ExpenseLogViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class ExpenseLogViewController: UIViewController {
    
    // MARK: - Properties
    var expenses = [Expense]()
    let expenseLogScreen = ExpenseLogView()
    
    override func loadView() {
        view = expenseLogScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Log"
        
        // Removing separator line from TableView
        expenseLogScreen.tableViewExpense.separatorStyle = .none
        
        // Register the custom cell class with the table view
        expenseLogScreen.tableViewExpense.register(TableViewExpenseCell.self, forCellReuseIdentifier: "expenses")
        
        // Setting the table view delegate and data source
        expenseLogScreen.tableViewExpense.delegate = self
        expenseLogScreen.tableViewExpense.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    
    // MARK: - Add Expense Delegate Method
    func delegateOnAddExpense(expense: Expense) {
        print("Added expense: \(expense)") // Debugging statement
        expenses.append(expense)
        expenseLogScreen.tableViewExpense.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ExpenseLogViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Returns the number of rows in the current section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    // Populate a cell for the current row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: debugging
        print("Cell at row \(indexPath.row) is being configured.")
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenses", for: indexPath) as! TableViewExpenseCell
        let expense = expenses[indexPath.row]
        
        if let uwDescription = expense.description {
            cell.labelDescription.text = "Description: \(uwDescription)"
        }
        
        if let uwAmount = expense.amount {
            cell.labelAmount.text = "Amount: $\(uwAmount)"
        }
        
        if let uwCategory = expense.category {
            cell.labelCategory.text = "Type: \(uwCategory)"
        }
        
        //MARK: setting the image of the receipt...
        if let uwImage = expense.image{
            cell.imageReceipt.image = uwImage
        }
        
        
        // Setting the date
//        if let uwDate = expense.date {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .none
//            cell.labelDate.text = dateFormatter.string(from: uwDate)
//        }
        return cell
    }
    
    // Handle user interaction with a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.expenses[indexPath.row])
    }
}
