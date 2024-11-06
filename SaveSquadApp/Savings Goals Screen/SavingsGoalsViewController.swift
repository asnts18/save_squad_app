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
    }
    
}
