//
//  Income.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/24/24.
//

import Foundation
import FirebaseFirestore

struct Income: Codable {
    @DocumentID var id: String?
    var amount: Double
    var description: String
    var frequency: String
    var incomeDate: Date
    
    var incomeDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: incomeDate)
    }
    
    init(amount: Double, description: String, frequency: String, incomeDate: Date) {
        self.amount = amount
        self.description = description
        self.frequency = frequency
        self.incomeDate = incomeDate
    }
}
