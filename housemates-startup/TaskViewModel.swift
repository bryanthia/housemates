//
//  TaskViewModel.swift
//  housemates-startup
//
//  Created by Bryan Thia on 17/11/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasksByDate: [Date: [Task]] =
    [Calendar.current.startOfDay(for: Date.now):
        [Task(title: "Floors", description: "Vacuum and Mop Floors"),
         Task(title: "Trash", description: "Compost, general & recyclable waste"),
         Task(title: "Kitchen", description: "Clean StoveTop and Ventilator")
        ]
    ]
    
    func addTask(for date: Date, task: Task) {
        var tasks = tasksByDate[date] ?? []
        tasks.append(task)
        tasksByDate[date] = tasks
    }
    
    func getTasks(for date: Date) -> [Task] {
        return tasksByDate[Calendar.current.startOfDay(for: date)] ?? []
    }
}
