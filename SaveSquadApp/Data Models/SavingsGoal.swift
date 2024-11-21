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
    var name: String       // The name of the savings goal
    var description: String // Description of the goal
    var cost: Double       // Target cost to reach the goal
    var targetDate: Date   // Target date to reach the goal
    var imageData: Data? // Store image as Data
        
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
    var targetDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: targetDate)
    }
    
    init(name: String, description: String, cost: Double, targetDate: Date, image: UIImage?) {
        self.name = name
        self.description = description
        self.cost = cost
        self.targetDate = targetDate
        self.image = image
    }
}
