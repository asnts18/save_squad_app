//
//  HomeScreenViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeScreenViewController: UIViewController {

    let homeScreen = HomeScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let db = Firestore.firestore()
    var budgetManager: BudgetManager?
    
    override func loadView() {
        view = homeScreen
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
                    .collection("goals")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            var earliestDocument: QueryDocumentSnapshot?
                            var earliestDate: Date?
                            for document in documents{
                                if let completed = document.get("completed") as? Bool {
                                    
                                    if completed == false {
                                        if let targetDate = document.get("targetDate") as? Timestamp {
                                            let date = targetDate.dateValue()
                                            if earliestDate == nil || date < earliestDate! {
                                                earliestDate = date
                                                earliestDocument = document
                                            }
                                        }
                                    } else {
                                        self.homeScreen.goalPic.image = UIImage(systemName: "photo.circle.fill")
                                    }
                                }
                            }
                            if let earliestDocument = earliestDocument {
                                self.homeScreen.goalLabel2.text = earliestDocument.get("name") as? String ?? "No Name"
                                let cost = earliestDocument.get("cost") as? Double ?? 0.0
                                if let timestamp = earliestDocument.get("targetDate") as? Timestamp {
                                    let targetDate = timestamp.dateValue()
                                    self.updateBudget(cost: cost, targetDate: targetDate)
                                } else {
                                    let targetDate = Date()
                                    self.updateBudget(cost: cost, targetDate: targetDate)
                                }
                                
                                // Fetch and load the image
                                if let imageURLString = earliestDocument.get("imageURL") as? String,
                                   let imageURL = URL(string: imageURLString) {
                                    self.homeScreen.goalPic.loadRemoteImage(from: imageURL)
                                }
                                
                            } else {
                                self.homeScreen.spendLabel2.text = "$00.00"
                                self.homeScreen.spendLabel3.text = "$00.00 remaining for the month"
                                self.homeScreen.goalLabel2.text = "None!"
                                self.homeScreen.goalLabel3.text = "Go to Goals tab to create a new goal"
                            }
                        }
                    })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
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
        let barIcon = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped)
        )
        let barText = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped)
        )
        barIcon.tintColor = .white
        barText.tintColor = .white
        navigationItem.rightBarButtonItems = [barIcon, barText]
        homeScreen.floatingButtonAdd.showsMenuAsPrimaryAction = true
        homeScreen.floatingButtonAdd.menu = UIMenu(title: "",
                                                   children: [
                                                    UIAction(title: "Add Income",handler: {(_) in
                                                        let addIncomeViewController = AddIncomeViewController()
                                                        self.navigationController?.pushViewController(addIncomeViewController, animated: true)
                                                    }),
                                                    UIAction(title: "Add Expense",handler: {(_) in
                                                        let addExpenseViewController = AddExpenseViewController()            
                                                        self.navigationController?.pushViewController(addExpenseViewController, animated: true)
                                                    })
                                                   ])
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
            do{
                try Auth.auth().signOut()
                let loginViewController = ViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let window = windowScene.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            }catch{
                print("Error occured!")
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }
    
    
    @objc func updateBudget(cost: Double, targetDate: Date) {

        // Fetch total income and total expenses
        getTotalIncome(targetDate: targetDate) { totalIncome in
            self.getTotalExpenses { totalExpenses in
                
                // Initialize the BudgetManager with the data
                print("Total Income: \(totalIncome), Total Expenses: \(totalExpenses), Savings Goal Amount: \(cost), Target Date: \(targetDate)")
                self.budgetManager = BudgetManager(totalIncome: totalIncome, totalExpenses: totalExpenses, savingsGoalAmount: cost, goalTargetDate: targetDate)
                
                // Get the daily budget and  remaining budget for the month
                if let dailyBudget = self.budgetManager?.getDailyBudget(),
                   let remainingBudget = self.budgetManager?.getRemainingBudgetForThisMonth()
                {
                    // Update the budget labels
                    self.updateBudgetLabels(dailyBudget: dailyBudget, remainingBudget: remainingBudget)
                }
                
            }
        }
    }
    
    func updateBudgetLabels(dailyBudget: Double, remainingBudget: Double) {
        if dailyBudget >= 0 {
            self.homeScreen.spendLabel2.text = String(format: "$%.2f", dailyBudget)
            self.homeScreen.goalLabel3.text = "You are on track to achieve your savings goal!"
        } else {
            self.homeScreen.spendLabel2.text = String(format: "-$%.2f", abs(dailyBudget))
            self.homeScreen.goalLabel3.text = "You are not on track to achieve your savings goal..."
        }
        
        if remainingBudget >= 0 {
            self.homeScreen.spendLabel3.text = String(format: "$%.2f", remainingBudget) + " remaining for the month"
        } else {
            self.homeScreen.spendLabel3.text = String(format: "-$%.2f", abs(remainingBudget)) + " remaining for the month"
        }
    
    }
    
    @objc func getTotalIncome(targetDate: Date, completion: @escaping (Double) -> Void) {
        var totalIncome = 0.0
        let calendar = Calendar.current
        self.db.collection("users").document(self.currentUser?.uid ?? "")
            .collection("income").getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error retrieving documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        let incomeData = document.data()
                        let amount = incomeData["amount"] as? Double ?? 0.0
                        let frequency = incomeData["frequency"] as? String ?? "One-time"
                        let incomeTimestamp = incomeData["incomeDate"] as? Timestamp ?? Timestamp(date: Date())
                        let incomeDate = incomeTimestamp.dateValue()
                        if frequency == "One-time" {
                            totalIncome += amount
                        } else {
                            var dailyBudget = 0.0
                            if frequency == "Weekly" {
                                dailyBudget = amount / 7
                            } else if frequency == "Semi-monthly" {
                                dailyBudget = (amount * 24) / 365
                            } else if frequency == "Monthly" {
                                dailyBudget = (amount * 12) / 365
                            } else if frequency == "Annual" {
                                dailyBudget = amount / 365
                            } else {
                                continue
                            }
                            let dateDiff = calendar.dateComponents([.day], from: incomeDate, to: targetDate).day ?? 0
                            let income = dailyBudget * Double(dateDiff)
                            totalIncome += income
                        }
                    }
                }
                completion(totalIncome)
        }
    }
    
    @objc func getTotalExpenses(completion: @escaping (Double) -> Void) {
        var totalExpenses = 0.0
        
        guard let uid = self.currentUser?.uid else {
            completion(totalExpenses)
            return
        }
        
        self.db.collection("users").document(uid)
            .collection("expenses")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error retrieving documents: \(error)")
                    completion(totalExpenses)
                } else {
                    for document in querySnapshot!.documents {
                        let expenseData = document.data()
                        let amount = expenseData["amount"] as? Double ?? 0.0
                        totalExpenses += amount
                    }
                    completion(totalExpenses)
                }
            }
    }


    
}
