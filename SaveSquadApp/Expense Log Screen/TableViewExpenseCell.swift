//
//  TableViewExpenseCell.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/6/24.
//
//

import UIKit


class TableViewExpenseCell: UITableViewCell {
    var expenseImageView: UIImageView!
    var labelDescription: UILabel!
    var labelAmount: UILabel!
    var labelCategory: UILabel!
    var labelDate: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabelDescription()
        setupLabelAmount()
        setupLabelCategory()
        setupLabelDate()
        setupExpenseImageView()
        initConstraints()
    }
    
    //MARK: defining the UI elements...
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
        labelAmount.textColor = .red
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelAmount)
    }
    func setupLabelCategory(){
        labelCategory = UILabel()
        labelCategory.font = UIFont.systemFont(ofSize: 14)
        labelCategory.textColor = .black
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelCategory)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 14)
        labelDate.textColor = .lightGray
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDate)
    }
    
    //MARK: Adding the ImageView
    func setupExpenseImageView(){
        expenseImageView = UIImageView()
        expenseImageView.image = UIImage(systemName: "photo")
        expenseImageView.contentMode = .scaleAspectFill
        expenseImageView.clipsToBounds = true
        expenseImageView.layer.cornerRadius = 10
        expenseImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expenseImageView)
    }
    
    
    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            expenseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            expenseImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            expenseImageView.widthAnchor.constraint(equalToConstant: 50),
            expenseImageView.heightAnchor.constraint(equalToConstant: 50),
            
            labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelDescription.leadingAnchor.constraint(equalTo: expenseImageView.trailingAnchor, constant: 15),
            labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            labelAmount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelAmount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            labelCategory.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 5),
            labelCategory.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelCategory.trailingAnchor.constraint(equalTo: labelDescription.trailingAnchor),

            labelDate.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelDate.trailingAnchor.constraint(equalTo: labelDescription.trailingAnchor),
            labelDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with expense: Expense) {
        if let imageURLString = expense.imageURL, let imageURL = URL(string: imageURLString) {
            expenseImageView.loadRemoteImage(from: imageURL)
        } else {
            expenseImageView.image = UIImage(systemName: "photo") // Fallback to default image
        }
        labelDescription.text = expense.description
        labelAmount.text = String(format: "-$%.2f", expense.amount ?? 00.00)
        labelCategory.text = "Category: \(expense.category ?? "Personal")"
        labelDate.text = "Date: \(expense.targetDateFormatted)"
    }

    
    //MARK: unused methods...
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
