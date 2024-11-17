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
        
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.currentUser = nil
            } else {
                self.currentUser = user
                let tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen.buttonRegister.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        //Go right to Tab Bar controller to skip login/test post-login experience
        //Comment these next two lines out if you want to test login/register screens
        /*
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)*/
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}

