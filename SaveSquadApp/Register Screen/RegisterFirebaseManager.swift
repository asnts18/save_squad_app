//
//  RegisterFirebaseManager.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/16/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){
        var firstName: String = ""
        var lastName: String = ""
        var email: String = ""
        var password: String = ""
        if let firstNameText = registerView.textFieldFirstName.text,
           let lastNameText = registerView.textFieldLastName.text,
           let emailText = registerView.textFieldEmail.text,
           let passwordText = registerView.textFieldPassword.text,
           let passwordRepeatText = registerView.textFieldVerifyPassword.text {
            if !firstNameText.isEmpty{
                firstName = firstNameText
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            if !lastNameText.isEmpty{
                lastName = lastNameText
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
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
                    self.showErrorAlert(message: "Please enter a password between 6-50 characters.")
                    return
                } else {
                    password = passwordText
                }
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            if !passwordRepeatText.isEmpty{
                if !(passwordText == passwordRepeatText) {
                    self.showErrorAlert(message: "Your passwords do not match.")
                    return
                }
            } else {
                self.showErrorAlert(message: "Fields cannot be left empty.")
                return
            }
            //showActivityIndicator()
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    let fullName = "\(firstName) \(lastName)"
                    self.setNameOfTheUserInFirebaseAuth(name: fullName)
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData([
                        "firstName": firstName,
                        "lastName": lastName,
                        "email": email
                    ])
                }else{
                    self.showErrorAlert(message: "There was an error creating the user because the email address is already in use.")
                    //self.hideActivityIndicator()
                    return
                }
            })
        }
        else{
            self.showErrorAlert(message: "Fields cannot be left empty.")
            //self.hideActivityIndicator()
            return
        }
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }else{
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}
