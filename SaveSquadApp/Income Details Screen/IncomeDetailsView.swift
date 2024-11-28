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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupLabelDescription()
        setupDetailsStack()
        setupLabelAmount()
        setupLabelFrequency()
        setupLabelDate()
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
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

    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 55),
            
            labelDescription.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            detailsStack.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            detailsStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailsStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
