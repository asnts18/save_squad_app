//
//  SocialGoal.swift
//  SaveSquadApp
//
//  Created by Haritha on 06/12/24.
//

import Foundation
import FirebaseFirestore

struct SocialGoal: Codable {
    @DocumentID var id: String?
    var userEmail: String
    var goalName: String
    var goalDescription: String
    var goalCost: Double
    var completedDate: Date
    var imageURL: String?
}