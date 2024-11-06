//
//  HomeScreenView.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit

class HomeScreenView: UIView {
    
    var floatingButtonAdd: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupFloatingButtonAdd()
        initConstraints()
    }
    
    func setupFloatingButtonAdd(){
        floatingButtonAdd = UIButton(type: .system)
        floatingButtonAdd.setTitle("", for: .normal)
        floatingButtonAdd.setImage(
            UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal
        )
        floatingButtonAdd.tintColor = .black
        floatingButtonAdd.contentHorizontalAlignment = .fill
        floatingButtonAdd.contentVerticalAlignment = .fill
        floatingButtonAdd.imageView?.contentMode = .scaleAspectFit
        floatingButtonAdd.layer.cornerRadius = 16
        floatingButtonAdd.imageView?.layer.shadowOffset = .zero
        floatingButtonAdd.imageView?.layer.shadowRadius = 0.8
        floatingButtonAdd.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAdd.imageView?.clipsToBounds = true
        floatingButtonAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAdd)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            floatingButtonAdd.widthAnchor.constraint(equalToConstant: 60),
            floatingButtonAdd.heightAnchor.constraint(equalToConstant: 60),
            floatingButtonAdd.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            floatingButtonAdd.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
