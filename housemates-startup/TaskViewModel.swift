//
//  TaskViewModel.swift
//  housemates-startup
//
//  Created by Bryan Thia on 17/11/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var dailyTasks: [DailyTasks] = 
                [DailyTasks(
                    id: UUID(),
                    date: DailyTasks.normalizedDate(from: Date()), // Today's date
                    tasks: [
                        Task(id: UUID(), title: "Morning Workout", time: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!, durationHours: 1.5), // 1.5 hours
                        Task(id: UUID(), title: "Team Standup Meeting", time: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!, durationHours: 0.5), // 0.5 hours (30 minutes)
                        Task(id: UUID(), title: "Lunch with Client", time: Calendar.current.date(bySettingHour: 12, minute: 30, second: 0, of: Date())!, durationHours: 1.0), // 1 hour
                        Task(id: UUID(), title: "Code Review", time: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!, durationHours: 2.0) // 2 hours
                    ]
                ),
                DailyTasks(
                    id: UUID(),
                    date: DailyTasks.normalizedDate(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!), // Tomorrow's date
                    tasks: [
                        Task(id: UUID(), title: "Write Blog Post", time: Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!, durationHours: 2.5), // 2.5 hours
                        Task(id: UUID(), title: "Client Call", time: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!, durationHours: 1.25), // 1.25 hours (1 hour 15 minutes)
                        Task(id: UUID(), title: "Project Planning", time: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!, durationHours: 1.5) // 1.5 hours
                    ]
                ),
                DailyTasks(
                    id: UUID(),
                    date: DailyTasks.normalizedDate(from: Calendar.current.date(byAdding: .day, value: 2, to: Date())!), // Day after tomorrow
                    tasks: [
                        Task(id: UUID(), title: "Grocery Shopping", time: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 2, to: Date())!)!, durationHours: 1.0), // 1 hour
                        Task(id: UUID(), title: "Visit Doctor", time: Calendar.current.date(bySettingHour: 13, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 2, to: Date())!)!, durationHours: 0.75), // 0.75 hours (45 minutes)
                        Task(id: UUID(), title: "Dinner with Friends", time: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Calendar.current.date(byAdding: .day, value: 2, to: Date())!)!, durationHours: 2.5) // 2.5 hours
                    ]
                )
            ]

    
    func addTask(to date: Date, task: Task) {
        let normalizedDate = DailyTasks.normalizedDate(from: date)

        if let index = dailyTasks.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: normalizedDate) }) {
            dailyTasks[index].tasks.append(task)
        } else {
            let newDay = DailyTasks(id: UUID(), date: normalizedDate, tasks: [task])
            dailyTasks.append(newDay)
            print(dailyTasks)
        }
    }
    
    func getTasks(for date: Date) -> [Task] {
            let normalizedDate = DailyTasks.normalizedDate(from: date)
            if let day = dailyTasks.first(where: { Calendar.current.isDate($0.date, inSameDayAs: normalizedDate) }) {
                return day.tasks
            }
            return []  // Return an empty array if no tasks for this date
        }
}
