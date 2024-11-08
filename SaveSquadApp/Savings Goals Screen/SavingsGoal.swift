//
//  SavingsGoal.swift
//  SaveSquadApp
//
//  Created by Bubesh Dev on 11/7/24.
//
import UIKit

struct SavingsGoal {
    var name: String       // The name of the savings goal
    var description: String // Description of the goal
    var cost: Double       // Target cost to reach the goal
    var targetDate: Date   // Target date to reach the goal
    var image: UIImage?    // Optional image associated with the goal
    
    // Computed property to format the target date as a string
    var targetDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: targetDate)
    }
}

