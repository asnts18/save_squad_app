//
//  IncomeLogTableViewManager.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import Foundation
import UIKit

extension IncomeLogViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? recurringIncomes.count : oneTimeIncomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomes", for: indexPath) as! TableViewIncomeCell
        let income = indexPath.section == 0 ? recurringIncomes[indexPath.row] : oneTimeIncomes[indexPath.row]
        cell.populateCell(income: income)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIncome = indexPath.section == 0 ? recurringIncomes[indexPath.row] : oneTimeIncomes[indexPath.row]
        let incomeDetailVC = IncomeDetailViewController()
        incomeDetailVC.income = selectedIncome
        navigationController?.pushViewController(incomeDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = section == 0 ? "Recurring:" : "One-time:"
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
