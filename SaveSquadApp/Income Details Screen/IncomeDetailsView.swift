//
//  IncomeDetailsView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/27/24.
//

import UIKit

class IncomeDetailsView: UIView {
    var titleBackgroundView: UIView!
    var labelDescription: UILabel!
    var detailsStack: UIStackView!
    var labelAmount: UILabel!
    var labelFrequency: UILabel!
    var labelDate: UILabel!
    var buttonStack: UIStackView!
    var buttonEdit: UIButton!
    var buttonDelete: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupLabelDescription()
        setupDetailsStack()
        setupLabelAmount()
        setupLabelFrequency()
        setupLabelDate()
        setupButtonStack()
        setupButtonEdit()
        setupButtonDelete()
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = Utilities.purple
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupLabelDescription() {
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 24)
        labelDescription.textAlignment = .center
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDescription)
    }
    
    func setupDetailsStack() {
        detailsStack = UIStackView()
        detailsStack.axis = .vertical
        detailsStack.spacing = 10
        detailsStack.alignment = .fill
        detailsStack.distribution = .fillEqually
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailsStack)
    }
    
    func setupLabelAmount() {
        labelAmount = UILabel()
        labelAmount.font = UIFont.systemFont(ofSize: 16)
        labelAmount.textColor = .darkGray
        labelAmount.textAlignment = .center
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        detailsStack.addArrangedSubview(labelAmount)
    }
    
    func setupLabelFrequency() {
        labelFrequency = UILabel()
        labelFrequency.font = UIFont.systemFont(ofSize: 16)
        labelFrequency.textColor = .darkGray
        labelFrequency.textAlignment = .center
        labelFrequency.translatesAutoresizingMaskIntoConstraints = false
        detailsStack.addArrangedSubview(labelFrequency)
    }
    
    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 16)
        labelDate.textColor = .darkGray
        labelDate.textAlignment = .center
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        detailsStack.addArrangedSubview(labelDate)
    }
    
    func setupButtonStack() {
        buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        buttonStack.alignment = .center
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStack)
    }
    
    func setupButtonEdit() {
        buttonEdit = UIButton(type: .system)
        buttonEdit.setTitle("Edit Income", for: .normal)
        buttonEdit.backgroundColor = .systemGreen
        buttonEdit.setTitleColor(.white, for: .normal)
        buttonEdit.layer.cornerRadius = 5
        buttonEdit.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.addArrangedSubview(buttonEdit)
    }
    
    func setupButtonDelete() {
        buttonDelete = UIButton(type: .system)
        buttonDelete.setTitle("Delete Income", for: .normal)
        buttonDelete.backgroundColor = .systemRed
        buttonDelete.setTitleColor(.white, for: .normal)
        buttonDelete.layer.cornerRadius = 5
        buttonDelete.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.addArrangedSubview(buttonDelete)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            labelDescription.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            detailsStack.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            detailsStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailsStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonStack.topAnchor.constraint(equalTo: detailsStack.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            buttonEdit.heightAnchor.constraint(equalToConstant: 50),
            buttonEdit.widthAnchor.constraint(equalToConstant: 200),
            buttonDelete.heightAnchor.constraint(equalToConstant: 50),
            buttonDelete.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
