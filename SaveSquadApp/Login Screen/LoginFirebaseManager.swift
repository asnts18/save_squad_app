//
//  LoginFirebaseManager.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/17/24.
//

import Foundation
import FirebaseAuth

extension ViewController{
    
    @objc func loginButtonTapped(){
        var email = ""
        var password = ""
        if let emailText = loginScreen.textFieldEmail.text,
           let passwordText = loginScreen.textFieldPassword.text {
            if !emailText.isEmpty{
                if !isValidEmail(emailText) {
                    self.showErrorAlert(message: "Please enter a valid email address.")
                    return
                } else {
                    email = emailText
                }
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            if !passwordText.isEmpty{
                if !isValidPassword(passwordText) {
                    self.showErrorAlert(message: "Incorrect password.")
                    return
                } else {
                    password = passwordText
                }
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
        }
        showActivityIndicator()
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                let tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            }else{
                self.showErrorAlert(message: "Incorrect email or password.")
            }
            self.hideActivityIndicator()
        })
    }
}
