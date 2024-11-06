//
//  HomeScreenViewController.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 10/31/24.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let homeScreen = HomeScreenView()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerTapped))
        //homeScreen.homeContainer.addGestureRecognizer(tapGesture)
    }

    @objc func containerTapped() {
        //print("Container tapped!")
    }

}
