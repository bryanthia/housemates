//
//  Date.swift
//  housemates-startup
//
//  Created by Bryan Thia on 15/11/2024.
//

import Foundation

extension Date {
    static let daysInAWeek: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    } 
    
    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var sundayAfterEnd: Date {
        let EndOfMonthWeekday = Calendar.current.component(.weekday, from: endOfMonth)
        let numberToNextMonth = 7 - EndOfMonthWeekday
        return Calendar.current.date(byAdding: .day, value: numberToNextMonth, to: endOfMonth)!
    }
    
    var sundayOfWeek: Date {
        let currentWeekday = Calendar.current.component(.weekday, from: self)
        let daysFromSunday = (currentWeekday - 1) % 7

        return Calendar.current.date(byAdding: .day, value: -daysFromSunday, to: self)!
        
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        for daysOffset in 0..<startOfNextMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: daysOffset, to: startOfNextMonth)
            days.append(newDay!)
        }
        
        // current
        for daysOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: daysOffset, to: startOfMonth)
            days.append(newDay!)
        }        
        
        for daysOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: daysOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        
        
        
        return days.filter { $0 >= sundayBeforeStart && $0 <= sundayAfterEnd }.sorted(by: <)
    }
    
    var allWeekDays: [Date] {
        var days: [Date] = []
        for weekdays in 0..<7 {
            days.append(self.sundayOfWeek.addToDate(numDays: weekdays))
        }
        return days
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    func addToDate(numDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    
}
