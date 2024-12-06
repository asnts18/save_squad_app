//
//  TableViewIncomeCell.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/26/24.
//

import UIKit

class TableViewIncomeCell: UITableViewCell {
    var labelDescription: UILabel!
    var labelAmount: UILabel!
    var labelFrequency: UILabel!
    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabelDescription()
        setupLabelAmount()
        setupLabelFrequency()
        setupLabelDate()
        initConstraints()
    }
    
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 18)
        labelDescription.textColor = .black
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDescription)
    }
    
    func setupLabelAmount(){
        labelAmount = UILabel()
        labelAmount.font = UIFont.boldSystemFont(ofSize: 24)
        labelAmount.textColor = .systemGreen
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelAmount)
    }
    
    func setupLabelFrequency(){
        labelFrequency = UILabel()
        labelFrequency.font = UIFont.systemFont(ofSize: 14)
        labelFrequency.textColor = .black
        labelFrequency.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelFrequency)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 14)
        labelDate.textColor = .lightGray
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDate)
    }
    
    func populateCell(income: Income) {
        labelDescription.text = income.description
        labelAmount.text = String(format: "$%.2f", income.amount)
        labelFrequency.text = "Frequency: \(income.frequency)"
        labelDate.text = "Date: \(income.incomeDateFormatted)"
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            labelDescription.trailingAnchor.constraint(lessThanOrEqualTo: labelAmount.leadingAnchor, constant: -15),

            labelAmount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelAmount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            labelFrequency.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 5),
            labelFrequency.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelFrequency.trailingAnchor.constraint(equalTo: labelDescription.trailingAnchor),
            
            labelDate.topAnchor.constraint(equalTo: labelFrequency.bottomAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelDate.trailingAnchor.constraint(equalTo: labelDescription.trailingAnchor),
            labelDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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

