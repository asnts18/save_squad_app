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
        setupFrequencyMenu()
    }

    func setupFrequencyMenu(){
        let menuOptions = [
            UIAction(title: "One-time", handler: { _ in
                self.addIncomeScreen.frequencyButton.setTitle("One-time", for: .normal)
            }),
            UIAction(title: "Weekly", handler: { _ in
                self.addIncomeScreen.frequencyButton.setTitle("Weekly", for: .normal)
            }),
            UIAction(title: "Semi-monthly", handler: { _ in
                self.addIncomeScreen.frequencyButton.setTitle("Semi-monthly", for: .normal)
            }),
            UIAction(title: "Monthly", handler: { _ in
                self.addIncomeScreen.frequencyButton.setTitle("Monthly", for: .normal)
            }),
            UIAction(title: "Annual", handler: { _ in
                self.addIncomeScreen.frequencyButton.setTitle("Annual", for: .normal)
            }),
        ]
        addIncomeScreen.frequencyButton.menu = UIMenu(title: "Select Frequency", children: menuOptions)
        addIncomeScreen.frequencyButton.showsMenuAsPrimaryAction = true
    }
}
