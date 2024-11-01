//
//  ViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 10/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeScreen = HomeScreenView()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

