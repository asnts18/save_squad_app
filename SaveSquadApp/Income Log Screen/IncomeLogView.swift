//
//  IncomeLogView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import UIKit

class IncomeLogView: UIView {
    var titleBackgroundView: UIView!
    var tableViewIncome: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupTableViewIncome()
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupTableViewIncome(){
        tableViewIncome = UITableView()
        tableViewIncome.separatorStyle = .singleLine
        tableViewIncome.register(TableViewIncomeCell.self, forCellReuseIdentifier: "incomes")
        tableViewIncome.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewIncome)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            tableViewIncome.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            tableViewIncome.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewIncome.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewIncome.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
