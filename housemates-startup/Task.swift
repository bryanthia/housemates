import Foundation

struct Task: Identifiable {
    var id: UUID
    var title: String
    var time: Date
    var durationHours: Double 
        
    var endTime: Date {
        let totalSeconds = durationHours * 3600 // Convert hours to seconds
        return time.addingTimeInterval(totalSeconds)
    }
    
    var formattedDuration: String {
            let totalMinutes = Int(durationHours * 60)
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60
            
            if hours > 0 && minutes > 0 {
                return "\(hours) hr \(minutes) min"
            } else if hours > 0 {
                return "\(hours) hr"
            } else {
                return "\(minutes) min"
            }
        }
}

struct DailyTasks: Identifiable {
    var id: UUID
    var date: Date
    var tasks: [Task]
    
    // Normalize date to midnight to avoid time issues
    static func normalizedDate(from date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: date)
    }
}
