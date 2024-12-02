//
//  HomeScreenView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit

class HomeScreenView: UIView {
    
    var titleBackgroundView: UIView!
    var contentWrapper: UIScrollView!
    var floatingButtonAdd: UIButton!
    var spendStack: UIStackView!
    var spendLabel1: UILabel!
    var spendLabel2: UILabel!
    var spendLabel3: UILabel!
    var goalStack: UIStackView!
    var goalLabel1: UILabel!
    var goalLabel2: UILabel!
    var imageContainer: UIView!
    var goalPic: UIImageView!
    var goalLabel3: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBackgroundView()
        setupContentWrapper()
        setupFloatingButtonAdd()
        setupSpendStack()
        setupSpendLabel1()
        setupSpendLabel2()
        setupSpendLabel3()
        setupGoalStack()
        setupGoalLabel1()
        setupGoalLabel2()
        setupImageContainer()
        setupGoalPic()
        setupGoalLabel3()
        initConstraints()
    }
    
    func setupBackgroundView() {
        titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .gray
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleBackgroundView)
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.delaysContentTouches = false
        contentWrapper.canCancelContentTouches = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupFloatingButtonAdd(){
        floatingButtonAdd = UIButton(type: .system)
        floatingButtonAdd.setTitle("", for: .normal)
        floatingButtonAdd.setImage(
            UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal
        )
        floatingButtonAdd.tintColor = .white
        floatingButtonAdd.backgroundColor = Utilities.purple
        floatingButtonAdd.contentHorizontalAlignment = .center
        floatingButtonAdd.contentVerticalAlignment = .center
        floatingButtonAdd.layer.cornerRadius = 30
        
        floatingButtonAdd.layer.shadowColor = UIColor.black.cgColor
        floatingButtonAdd.layer.shadowOffset = CGSize(width: 0, height: 2)
        floatingButtonAdd.layer.shadowRadius = 4
        floatingButtonAdd.layer.shadowOpacity = 0.7
        floatingButtonAdd.clipsToBounds = false 
        floatingButtonAdd.imageView?.clipsToBounds = true
        floatingButtonAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAdd)
    }
    
    func setupSpendStack(){
        spendStack = UIStackView()
        spendStack.axis = .vertical
        spendStack.alignment = .center
        spendStack.distribution = .fillProportionally
        spendStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(spendStack)
    }
    
    func setupSpendLabel1(){
        spendLabel1 = UILabel()
        spendLabel1.text = "Daily Spending Limit:"
        spendLabel1.font = .boldSystemFont(ofSize: 20)
        spendLabel1.translatesAutoresizingMaskIntoConstraints = false
        spendStack.addArrangedSubview(spendLabel1)
    }
    
    func setupSpendLabel2(){
        spendLabel2 = UILabel()
        spendLabel2.text = "$00.00"
        spendLabel2.font = .boldSystemFont(ofSize: 40)
        spendLabel2.translatesAutoresizingMaskIntoConstraints = false
        spendStack.addArrangedSubview(spendLabel2)
    }
    
    func setupSpendLabel3(){
        spendLabel3 = UILabel()
        spendLabel3.text = "$00.00 remaining for the month"
        spendLabel3.font = .boldSystemFont(ofSize: 14)
        spendLabel3.translatesAutoresizingMaskIntoConstraints = false
        spendStack.addArrangedSubview(spendLabel3)
    }
    
    func setupGoalStack(){
        goalStack = UIStackView()
        goalStack.axis = .vertical
        goalStack.alignment = .center
        goalStack.distribution = .equalSpacing
        goalStack.backgroundColor = .lightGray
        goalStack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        goalStack.isLayoutMarginsRelativeArrangement = true
        goalStack.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(goalStack)
    }
    
    func setupGoalLabel1(){
        goalLabel1 = UILabel()
        goalLabel1.text = "Your Current Goal:"
        goalLabel1.font = .boldSystemFont(ofSize: 14)
        goalLabel1.translatesAutoresizingMaskIntoConstraints = false
        goalStack.addArrangedSubview(goalLabel1)
    }
    
    func setupGoalLabel2(){
        goalLabel2 = UILabel()
        goalLabel2.text = "None!"
        goalLabel2.font = .boldSystemFont(ofSize: 22)
        goalLabel2.translatesAutoresizingMaskIntoConstraints = false
        goalStack.addArrangedSubview(goalLabel2)
    }
    
    func setupImageContainer() {
        imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.backgroundColor = .white
        imageContainer.layer.cornerRadius = 75
        imageContainer.clipsToBounds = true
        goalStack.addArrangedSubview(imageContainer)
    }
    
    func setupGoalPic(){
        goalPic = UIImageView()
        goalPic.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysOriginal)
        goalPic.tintColor = .black
        goalPic.contentMode = .scaleAspectFit
        goalPic.backgroundColor = .white
        goalPic.layer.borderColor = UIColor.white.cgColor
        goalPic.layer.borderWidth = 3
        goalPic.clipsToBounds = true
        goalPic.layer.masksToBounds = true
        goalPic.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(goalPic)
    }
    
    func setupGoalLabel3(){
        goalLabel3 = UILabel()
        goalLabel3.text = "Go to Goals tab to create a new goal"
        goalLabel3.font = .boldSystemFont(ofSize: 14)
        goalLabel3.translatesAutoresizingMaskIntoConstraints = false
        goalStack.addArrangedSubview(goalLabel3)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            titleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            floatingButtonAdd.widthAnchor.constraint(equalToConstant: 60),
            floatingButtonAdd.heightAnchor.constraint(equalToConstant: 60),
            floatingButtonAdd.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            floatingButtonAdd.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            spendStack.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 16),
            spendStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            spendStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            spendStack.heightAnchor.constraint(equalToConstant: 150),
            
            goalStack.topAnchor.constraint(equalTo: spendStack.bottomAnchor, constant: 60),
            goalStack.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 16),
            goalStack.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -16),
            goalStack.heightAnchor.constraint(equalToConstant: 280),
            
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            imageContainer.heightAnchor.constraint(equalToConstant: 150),
            
            goalPic.widthAnchor.constraint(equalTo: imageContainer.widthAnchor, multiplier: 0.8),
            goalPic.heightAnchor.constraint(equalTo: imageContainer.heightAnchor, multiplier: 0.8),
            goalPic.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            goalPic.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            
            goalStack.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
