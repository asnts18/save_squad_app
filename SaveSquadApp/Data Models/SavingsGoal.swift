//
//  SavingsGoal.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//
import Foundation
import FirebaseFirestore

struct SavingsGoal: Codable {
    @DocumentID var id: String?
    var name: String?       // The name of the savings goal
    var description: String? // Description of the goal
    var cost: Double?       // Target cost to reach the goal
    var targetDate: Date   // Target date to reach the goal
    var imageURL: String?  // URL of the image in Firebase Storage
    var completed: Bool
    
    var targetDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: targetDate)
    }
    
    init(name: String, description: String, cost: Double, targetDate: Date, imageURL: String?, completed: Bool) {
        self.name = name
        self.description = description
        self.cost = cost
        self.targetDate = targetDate
        self.imageURL = imageURL
        self.completed = completed
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "name": name ?? "",
            "description": description ?? "",
            "cost": cost ?? 0.0,
            "targetDate": targetDate,
            "completed": completed
        ]
        
        if let imageURL = imageURL {
            dict["imageURL"] = imageURL
        }

        return dict
    }

}
