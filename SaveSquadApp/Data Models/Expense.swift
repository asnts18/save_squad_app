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
    
    var targetDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
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
    
    init(amount: Double, description: String, category: String, date: Date, image: UIImage?) {
        self.amount = amount
        self.description = description
        self.category = category
        self.date = date
        self.image = image
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "amount": amount ?? 0.0,
            "description": description ?? "",
            "category": category ?? "",
            "date": date
        ]

        return dict
    }
}
