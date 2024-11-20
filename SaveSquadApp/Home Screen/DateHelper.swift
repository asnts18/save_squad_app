//
//  DateHelper.swift
//  SaveSquadApp
//
//  Created by Colin Kenny on 11/19/24.
//

import Foundation

extension Date {
    var startOfMonth: Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
    }
}
