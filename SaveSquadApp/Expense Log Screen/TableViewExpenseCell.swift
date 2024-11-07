//
//  TableViewExpenseCell.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/6/24.
//
//

import UIKit

class TableViewExpenseCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelDescription: UILabel!
    var labelAmount: UILabel!
    var labelCategory: UILabel!
    
    //MARK: declaring the ImageView for receipt image...
    var imageReceipt: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabelDescription()
        setupLabelAmount()
        setupLabelCategory()
        
        //MARK: defining the ImageView for receipt image...
        setupimageReceipt()
        initConstraints()
    }
    
    //MARK: defining the UI elements...
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.7
        
        
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }
    func setupLabelAmount(){
        labelAmount = UILabel()
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAmount)
    }
    func setupLabelCategory(){
        labelCategory = UILabel()
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCategory)
    }
    
    //MARK: Adding the ImageView for receipt...
    func setupimageReceipt(){
        imageReceipt = UIImageView()
        imageReceipt.image = UIImage(systemName: "photo")
        imageReceipt.contentMode = .scaleToFill
        imageReceipt.clipsToBounds = true
        imageReceipt.layer.cornerRadius = 10
        imageReceipt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageReceipt)
    }
    
    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelDescription.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 2),
            labelDescription.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor, constant: 8),
            labelDescription.heightAnchor.constraint(equalToConstant: 32),
            labelDescription.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelAmount.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 2),
            labelAmount.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelAmount.heightAnchor.constraint(equalToConstant: 32),
            labelAmount.widthAnchor.constraint(lessThanOrEqualTo: labelDescription.widthAnchor),
            
            labelCategory.topAnchor.constraint(equalTo: labelAmount.bottomAnchor, constant: 2),
            labelCategory.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelCategory.heightAnchor.constraint(equalToConstant: 32),
            labelCategory.widthAnchor.constraint(lessThanOrEqualTo: labelDescription.widthAnchor),
            
            imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            //MARK: it is better to set the height and width of an ImageView with constraints...
            imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 104)
        ])
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
