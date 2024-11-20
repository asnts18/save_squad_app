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
                            } else {
                                print("No valid targetDate found in documents")
                            }
                        }
                    })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
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
                                                        addExpenseViewController.delegate = ExpenseLogViewController()
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
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }
    
    @objc func updateBudget(cost: Double, targetDate: Date) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        if let daysDifference = calendar.dateComponents([.day], from: today, to: targetDate).day {
            let savePerDay = cost / Double(daysDifference)
            let dailyBudget = 0 - savePerDay
            if dailyBudget >= 0 {
                self.homeScreen.spendLabel2.text = String(format: "$%.2f", dailyBudget)
                self.homeScreen.goalLabel3.text = "You are on track to achieve your savings goal!"
            } else {
                self.homeScreen.spendLabel2.text = String(format: "-$%.2f", abs(dailyBudget))
                self.homeScreen.goalLabel3.text = "You are not on track to achieve your savings goal..."
            }
            if let firstDayNextMonth = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: today))?.startOfMonth {
                var daysDifference = Int()
                if targetDate < firstDayNextMonth {
                    daysDifference = calendar.dateComponents([.day], from: today, to: targetDate).day ?? 0
                } else {
                    daysDifference = calendar.dateComponents([.day], from: today, to: firstDayNextMonth).day ?? 0
                }
                let budgetThisMonth = dailyBudget * Double(daysDifference)
                if budgetThisMonth >= 0 {
                    self.homeScreen.spendLabel3.text = String(format: "$%.2f", budgetThisMonth) + " remaining for the month"
                } else {
                    self.homeScreen.spendLabel3.text = String(format: "-$%.2f", abs(budgetThisMonth)) + " remaining for the month"
                }
            }
        }
    }
}
