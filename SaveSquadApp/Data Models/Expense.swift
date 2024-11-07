//
//  Expense.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/6/24.
//

import Foundation
import UIKit

struct Expense {
    var amount: Double?
    var description: String?
    var category: String?
//    var date: Date?
    var image: UIImage?
    
    init(amount: Double, description: String, category: String, image: UIImage) {
        self.amount = amount
        self.description = description
        self.category = category
//        self.date = date
        self.image = image
    }
}
