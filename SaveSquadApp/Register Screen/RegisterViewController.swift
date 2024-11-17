//
//  RegisterViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/16/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.buttonCreateAccount.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onRegisterTapped(){
        registerNewAccount()
    }

    /*
     Shows appropriate error alert depending on the message value that is inputted.
     */
    func showErrorAlert(message:String){
        let alert = UIAlertController(
                title: "Error!", message: message,
                preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    /*
     Returns boolean value based on whether the inputted string is a valid email address.
     Code borrowed from https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift/25471164#25471164
     */
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "[A-Z0-9a-z._%+-@$&*!#?]{6,50}"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
