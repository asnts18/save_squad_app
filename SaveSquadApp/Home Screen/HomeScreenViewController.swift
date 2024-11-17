//
//  HomeScreenViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit
import FirebaseAuth

class HomeScreenViewController: UIViewController {

    let homeScreen = HomeScreenView()
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
}
