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
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
