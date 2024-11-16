//
//  MonthlyView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 14/11/2024.
//

import SwiftUI

struct MonthlyView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var date = Date.now
    @State private var days: [Date] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Text(date, format: Date.FormatStyle().month().year())
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    DatePicker("", selection: $date, displayedComponents: [.date]
                    ).datePickerStyle(CompactDatePickerStyle())
                }
                .padding(.bottom)
                .padding(.horizontal, 16)
                
                Group{
                    HStack() {
                        ForEach(Date.daysInAWeek, id: \.self) { day in
                            Text(day)
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                        }
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) { day in
                            if day.monthInt != date.monthInt {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                            } else {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(
                                        Circle()
                                            .foregroundStyle(
                                                Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: day)
                                                ? Color.red.opacity(0.3) : Color.blue.opacity(0.3)
                                            )
                                    )
                                
                            }
                        }
                    }
                    
                    NavigationLink("Go to weekly view", destination: WeeklyView())
                        .padding(.vertical, 8)
                }.padding(.horizontal, 12)
                Spacer()
            }
            .padding(.top, 40)
            .onAppear() {
                days = date.calendarDisplayDays
            }
            .onChange(of: date) {
                days = date.calendarDisplayDays
            }
        }
    }
}

#Preview {
    MonthlyView()
}
