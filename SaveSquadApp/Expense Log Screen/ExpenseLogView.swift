//
//  ExpenseLogView.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/21/24.
//

import UIKit

class ExpenseLogView: UIView {
    
    var titleBackgroundView: UIView!
    var tableViewExpense: UITableView!
    var labelTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupBackgroundView()
        setupLabelTitle()
        setupTableViewExpense()
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupLabelTitle(){
        labelTitle = UILabel()
        labelTitle.text = "Expenses"
        labelTitle.font = UIFont.boldSystemFont(ofSize: 24) // Large font size
        labelTitle.textColor = .white
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundView.addSubview(labelTitle)
    }
    
    func setupTableViewExpense(){
        tableViewExpense = UITableView()
        tableViewExpense.separatorStyle = .singleLine
        tableViewExpense.register(TableViewExpenseCell.self, forCellReuseIdentifier: "expenses")
        tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewExpense)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 120),
            
            labelTitle.centerXAnchor.constraint(equalTo: titleBackgroundView.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: titleBackgroundView.centerYAnchor, constant: 20),
            
            tableViewExpense.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            tableViewExpense.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewExpense.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableViewExpense.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
