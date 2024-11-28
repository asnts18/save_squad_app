//
//  IncomeDetailViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/27/24.
//

import UIKit

class IncomeDetailViewController: UIViewController {
    
    var income:Income!
    let incomeDetailsScreen = IncomeDetailsView()
    
    override func loadView() {
        view = incomeDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Income Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let smallTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes
        self.navigationController?.navigationBar.tintColor = .white
        setLabelsText()
    }


    func setLabelsText() {
        incomeDetailsScreen.labelDescription.text = income.description
        incomeDetailsScreen.labelAmount.text = String(format: "Amount: $%.2f", income.amount)
        incomeDetailsScreen.labelFrequency.text = "Frequency: \(income.frequency)"
        incomeDetailsScreen.labelDate.text = "Date: \(income.incomeDateFormatted)"
    }
}
