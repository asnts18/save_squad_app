//
//  BudgetManager.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/23/24.
//

import Foundation

class BudgetManager {
    var monthlyIncome: Double
    var monthlyExpenses: Double
    var savingsGoalAmount: Double
    var goalTargetDate: Date
    var goalStartDate: Date
    var currentDate: Date


    init(monthlyIncome: Double, monthlyExpenses: Double, savingsGoalAmount: Double,
         goalTargetDate: Date,  goalStartDate: Date, currentDate: Date) {
        self.monthlyIncome = monthlyIncome // get income from firebase, monthly breakdown ?? 0
        self.monthlyExpenses = monthlyExpenses  // get sum of expenses from firebase for the month ?? 0
        self.goalTargetDate = goalTargetDate  // get target date of current goal ?? none
        self.savingsGoalAmount = savingsGoalAmount // get savings goals of current goal ?? 0
        self.goalStartDate = goalStartDate  // get created date of current goal ?? none
        self.currentDate = currentDate // today
    }

    // Update current date for testing
    func updateCurrentDate(newDate: Date) {
        self.currentDate = newDate
    }
    
    // MARK: SETTER AND GETTER METHODS

    /* Gets the daily budget after accounting for daily savings requirement and expenses for the month */
    func getAdjustedDailyBudget() -> Double {
        return calculateAdjustedDailyBudget()
    }
    
    /* Gets the remaining monthly budget after accounting for savings requirement and expenses for the month */
//    func getRemainingMonthlyBudget() -> Double {
//        return calculateRemainingMonthlyBudget()
//    }
    
    /* Gets the monthly income */
    func getIncome(newIncome: Double) {
        self.monthlyIncome = newIncome
    }
    
    /* Sets the monthly income */
    func setIncome(newIncome: Double) {
        self.monthlyIncome = newIncome
    }
    
    /* Gets the total expenses amount */
    func getExpenses(newExpenses: Double) {
        self.monthlyExpenses = newExpenses
    }
    
    /* Sets the total expenses amount */
    func setExpenses(newExpenses: Double) {
        self.monthlyExpenses = newExpenses
    }
    
    /* Sets current savings goal amount */
    func setSavingsGoal(newSavingsGoalAmount: Double) {
        self.savingsGoalAmount = newSavingsGoalAmount
    }

    /* Sets new target date based on current savings goal */
    func setTargetDate(newGoalTargetDate: Date) {
        self.goalTargetDate = newGoalTargetDate
    }
    
    // MARK: BUDGET CALCULATION METHODS
    
    /* Calculates daily budget available to spend AFTER accounting for daily savings requirements and expenses */
    private func calculateAdjustedDailyBudget() -> Double {
        // Calculate daily allocation of monthly income and expenses
         let dailyIncome = self.monthlyIncome / Double(calculateDaysInCurrentMonth())
         let dailyExpenses = self.monthlyExpenses / Double(calculateDaysInCurrentMonth())
        
        // Calculate daily savings requirement to achieve the goal
        var dailySavingsRequirement = 0.0
         if self.currentDate <= self.goalTargetDate {
             dailySavingsRequirement = self.savingsGoalAmount / Double(calculateStartDateToTargetDate())
        }
        
        // Adjusted Daily Budget: (Daily Income - Daily Savings Requirement - Daily Expenses)
        return dailyIncome - dailySavingsRequirement - dailyExpenses
    }
    
    /* Calculates the amount of savings that needs to be set aside for the current month
     to meet savings goal by the target date. */
    func calculateSavingsRequirementForCurrentMonth() -> Double {
        let dailySavingsRequirement = self.savingsGoalAmount / Double(calculateStartDateToTargetDate())
        let calendar = Calendar.current
        
        // Get the start and end of the current month
        let range = calendar.range(of: .day, in: .month, for: self.currentDate)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self.currentDate))!
        let endOfMonth = calendar.date(byAdding: .day, value: range.count - 1, to: startOfMonth)!
        
        // Determine the relevant start and end dates for calculation
        let start = max(self.goalStartDate, startOfMonth)
        let end = min(self.goalTargetDate, endOfMonth)
        
        // If the range is valid within the current month
        if start <= end {
            let daysInRange = calendar.dateComponents([.day], from: start, to: end).day! + 1
            print(daysInRange) // TODO: debug
            return dailySavingsRequirement * Double(daysInRange)
        }
        
        // Default case: No savings required in the current month
        return 0.0
    }
    
    // TODO: implement calculateRemainingMonthlyBudget()
    
    // MARK: Helper methods
    
    /* Calculates number of days from Goal Start Date to Target Date */
    func calculateStartDateToTargetDate() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: goalStartDate, to: goalTargetDate)
        
        // Add 1 to include the start date from the calculation
        return components.day! + 1
    }

    
    /* Calculates number of days in current month */
    func calculateDaysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: currentDate)!.count
    }
    
    // MARK: Income helper methods
    
    

}
