//
//  SocialFeedViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/6/24.
//

import UIKit

class SocialFeedViewController: UIViewController {

    let socialScreen = SocialFeedView()
    
    override func loadView() {
        view = socialScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Social"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .gray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let smallTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes
        self.navigationController?.navigationBar.tintColor = .white
    }

}
