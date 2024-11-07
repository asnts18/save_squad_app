//
//  SavingsGoalsViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class SavingsGoalsViewController: UIViewController {

    let savingsGoalsScreen = SavingsGoalsView()
    
    override func loadView() {
        view = savingsGoalsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Goals"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
