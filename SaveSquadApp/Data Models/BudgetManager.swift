//
//  BudgetManager.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/23/24.
//

import Foundation

class BudgetManager {
    var totalIncome: Double?
    var totalExpenses: Double?
    var savingsGoalAmount: Double?
    var goalTargetDate: Date?


    init(totalIncome: Double?, totalExpenses: Double?, savingsGoalAmount: Double?,
         goalTargetDate: Date?) {
        self.totalIncome = totalIncome ?? 0
        self.totalExpenses = totalExpenses ?? 0
        self.goalTargetDate = goalTargetDate
        self.savingsGoalAmount = savingsGoalAmount ?? 0
    }
    
    // MARK: SETTERS AND GETTERS
 
    
    /* Gets the daily budget */
    func getDailyBudget() -> Double {
        return calculateDailyBudget()
    }
    
    /* Gets the daily budget */
    func getRemainingBudgetForThisMonth() -> Double {
        return calculateRemainingBudgetForThisMonth()
    }
    
    
    /* Calculates daily budget available to spend AFTER accounting for daily savings requirements and expenses */
    private func calculateDailyBudget() -> Double {
        let daysToTargetDate: Double
        
        if self.goalTargetDate != nil {
            // If there is a target date, calculate days to target date
            daysToTargetDate = Double(calculateCurrentDateToTargetDate() ?? 0)
            print("daysToTargetDate: \(daysToTargetDate)")
        } else {
            // If there is no target date, use days in the current month
            daysToTargetDate = Double(calculateDaysInCurrentMonth())
        }
        
        // Ensure that we don't divide by zero if daysToTargetDate is zero
        guard daysToTargetDate > 0 else {
            return 0
        }
        
        let totalIncome = self.totalIncome ?? 0
        let savingsGoalAmount = self.savingsGoalAmount ?? 0
        let totalExpenses = self.totalExpenses ?? 0
        print("totalIncome: \(totalIncome), savingsGoalAmount: \(savingsGoalAmount), totalExpenses: \(totalExpenses),")


        return (totalIncome - savingsGoalAmount - totalExpenses) / daysToTargetDate
    }

    
    /* Calculates remaining budget for the month */
    private func calculateRemainingBudgetForThisMonth() -> Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dailyBudget = calculateDailyBudget()

        if let firstDayNextMonth = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: today))?.startOfMonth {
            print("firstDayNextMonth: \(firstDayNextMonth)")

            var daysDifference = 0
            
            // If there is a targetDate, calculate days difference to target date
            if let targetDate = goalTargetDate {
                if targetDate < firstDayNextMonth {
                    daysDifference = calendar.dateComponents([.day], from: today, to: targetDate).day ?? 0
                    print("days from today to target date: \(daysDifference)")

                } else {
                    daysDifference = calendar.dateComponents([.day], from: today, to: firstDayNextMonth).day ?? 0
                    print("days from today to firstDayNextMonth: \(daysDifference)")

                }
            } else {
                // If no targetDate, calculate days to the first day of next month
                daysDifference = calendar.dateComponents([.day], from: today, to: firstDayNextMonth).day ?? 0
            }
            
            // Calculate the remaining budget for the month
            let budgetThisMonth = dailyBudget * Double(daysDifference)
            print("budgetThisMonth: \(budgetThisMonth)")

            return budgetThisMonth
        }
        
        // Return 0 if we couldn't calculate firstDayNextMonth (safety check)
        return 0
    }

    // MARK: HELPER METHODS
 
    /* Calculates number of days from Current Date to Target Date */
    func calculateCurrentDateToTargetDate() -> Int? {
        guard let targetDate = self.goalTargetDate else {
            return nil
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date()) // Get the start of today's date
        let daysDifference = calendar.dateComponents([.day], from: today, to: targetDate).day
        return daysDifference
    }


    /* Calculates number of days in the current month */
    private func calculateDaysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let today = Date() // Get today's date
        
        // Get the range of days in the current month
        let range = calendar.range(of: .day, in: .month, for: today)
        
        // Return the count of days in the current month
        return range?.count ?? 0
    }


}
