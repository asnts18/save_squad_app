//
//  ViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 10/23/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let loginScreen = LoginView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
            let tabBarController = TabBarController()
            self.navigationController?.pushViewController(tabBarController, animated: true)
        } else {
            self.currentUser = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen.buttonRegister.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}

