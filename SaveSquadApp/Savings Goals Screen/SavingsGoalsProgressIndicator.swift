//
//  CreateGoalProgressIndicator.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 12/5/24.
//

import Foundation

extension SavingsGoalsViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
