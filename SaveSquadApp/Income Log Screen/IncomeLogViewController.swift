//
//  IncomeLogViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class IncomeLogViewController: UIViewController {
    let incomeLogScreen = IncomeLogView()
    var oneTimeIncomes: [Income] = []
    var recurringIncomes: [Income] = []
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func loadView() {
        view = incomeLogScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Income"
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
        incomeLogScreen.tableViewIncome.delegate = self
        incomeLogScreen.tableViewIncome.dataSource = self
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
                    .collection("income")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.oneTimeIncomes.removeAll()
                            self.recurringIncomes.removeAll()
                            for document in documents{
                                if let frequency = document.get("frequency") as? String {
                                    if frequency == "One-time" {
                                        do{
                                            let income = try document.data(as: Income.self)
                                            self.oneTimeIncomes.append(income)
                                        }catch{
                                            print(error)
                                        }
                                    } else {
                                        do{
                                            let income = try document.data(as: Income.self)
                                            self.recurringIncomes.append(income)
                                        }catch{
                                            print(error)
                                            print("recurring")
                                        }
                                    }
                                }
                            }
                            self.oneTimeIncomes.sort(by: {$0.incomeDate > $1.incomeDate})
                            self.recurringIncomes.sort(by: {$0.incomeDate > $1.incomeDate})
                            self.incomeLogScreen.tableViewIncome.reloadData()
                        }
                    })
            }
        }
    }
}
