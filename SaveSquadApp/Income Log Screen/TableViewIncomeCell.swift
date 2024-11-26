//
//  TableViewIncomeCell.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import UIKit

class TableViewIncomeCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelDescription: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabelDescription()
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 18)
        labelDescription.textColor = .black
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }
    
    func populateCell(income: Income) {
        labelDescription.text = income.description
        //labelAmount.text = String(format: "-$%.2f", expense.amount ?? 0)
        //labelCategory.text = "Category: \(expense.category ?? "Personal")"
        //labelDate.text = "Date: \(expense.targetDateFormatted)"
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelDescription.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelDescription.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 15),
            labelDescription.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
