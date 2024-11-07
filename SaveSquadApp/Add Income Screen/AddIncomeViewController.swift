//
//  AddIncomeViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class AddIncomeViewController: UIViewController {

    let addIncomeScreen = AddIncomeView()
    
    override func loadView() {
        view = addIncomeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Income"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = .white
    }

}
