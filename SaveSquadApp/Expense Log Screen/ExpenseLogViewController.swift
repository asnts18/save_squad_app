//
//  ExpenseLogViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/20/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ExpenseLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {    
    // MARK: - Properties
    let expenseLogScreen = ExpenseLogView()
    var expenses: [Expense] = []
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func loadView() {
        view = expenseLogScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Log"
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Setting the table view delegate and data source
        expenseLogScreen.tableViewExpense.delegate = self
        expenseLogScreen.tableViewExpense.dataSource = self
        
        // Add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNewExpense(_:)), name: NSNotification.Name("NewExpenseAdded"), object: nil)

        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                self.currentUser = nil
                let loginViewController = ViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                            
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let window = windowScene.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            }else{
                self.currentUser = user
                self.db.collection("users")
                    .document((self.currentUser?.uid ?? ""))
                    .collection("expenses")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.expenses.removeAll()
                            for document in documents{
                                do{
                                    let expense = try document.data(as: Expense.self)
                                    self.expenses.append(expense)
                                } catch {
                                    print(error)
                                }
                            }
                            self.expenses.sort(by: {$0.date < $1.date})
                            self.expenseLogScreen.tableViewExpense.reloadData()
                        }
                    })
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: Add new expense to Firestore and expense list
    @objc func didReceiveNewExpense(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let newExpense = userInfo["newExpense"] as? Expense, // Access Expense object
              let newExpenseData = userInfo["newExpenseData"] as? [String: Any] else {
            return
        }

        // Print for debugging purposes
        print("New Expense Object: \(newExpense)")
        print("New Expense Data Dictionary: \(newExpenseData)")

        // Save the expense to Firestore using the newExpenseData dictionary
        let userID = self.currentUser?.uid ?? "" // Ensure valid user ID
        db.collection("users").document(userID)
            .collection("expenses").addDocument(data: newExpenseData) { error in
                if let error = error {
                    print("Error saving expense: \(error.localizedDescription)")
                } else {
                    print("New Expense saved successfully!")
                    
                    // Post notification to update budget in homescreen
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateBudget"), object: nil, userInfo: ["newExpenseData": newExpenseData])

                    self.expenses.append(newExpense) // Add newExpense object to expenses list
                    self.expenseLogScreen.tableViewExpense.reloadData()  // Reload table
                }
            }
    }


    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NewExpenseAdded"), object: nil)
    }
    
    // MARK: deleting an Expense
    func deleteExpense(_ expense: Expense) {
        db.collection("users").document(self.currentUser?.uid ?? "")
            .collection("expenses").document("\(expense.id ?? "")").delete { error in
                if let error = error {
                    print("Error deleting expense: \(error.localizedDescription)")
                } else {
                    print("Expense successfully deleted")
                }
            }
    }
    
    // Returns the number of rows in the current section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    // Populate a cell for the current row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cell at row \(indexPath.row) is being configured.")
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenses", for: indexPath) as! TableViewExpenseCell
        let expense = expenses[indexPath.row]
        cell.configure(with: expense)
        return cell
    }
    
    // TODO: debug: Handle user interaction with a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.expenses[indexPath.row])
    }
}
