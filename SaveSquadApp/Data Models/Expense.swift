//
//  Expense.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/6/24.
//

import Foundation
import FirebaseFirestore

struct Expense: Codable {
    @DocumentID var id: String?
    var amount: Double? // Expense amount
    var description: String? // Description of expense
    var category: String? // Category of expense
    var date: Date // Date of transaction
    var imageURL: String? // URL of the image in Firebase Storage

    var targetDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    init(amount: Double, description: String, category: String, date: Date, imageURL: String?) {
        self.amount = amount
        self.description = description
        self.category = category
        self.date = date
        self.imageURL = imageURL
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "amount": amount ?? 0.0,
            "description": description ?? "",
            "category": category ?? "",
            "date": date
        ]
        
        if let imageURL = imageURL {
            dict["imageURL"] = imageURL
        }

        return dict
    }
}
