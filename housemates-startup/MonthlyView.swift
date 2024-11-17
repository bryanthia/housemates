//
//  MonthlyView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 14/11/2024.
//

import SwiftUI

struct MonthlyView: View {
    
    @StateObject var viewModel = TaskViewModel()
    @State var date: Date
    @State private var days: [Date] = []
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text(date, format: Date.FormatStyle().month().year())
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    DatePicker("", selection: $date, displayedComponents: [.date]
                    ).datePickerStyle(CompactDatePickerStyle())
                    Spacer()
                    HStack(alignment: .center) {
                        Button(action: {
                            date = Calendar.current.date(byAdding: .day, value: -date.startOfPreviousMonth.numberOfDaysInMonth, to: date)!
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        
                        Button(action: {
                            date = Date.now
                        }) {
                            Image(systemName: "house")
                        }
                        
                        Button(action: {
                            date = Calendar.current.date(byAdding: .day, value: date.numberOfDaysInMonth, to: date)!
                        }) {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal, 16)
                
                Group{
                    HStack() {
                        ForEach(Date.daysInAWeek, id: \.self) { day in
                            Text(day.prefix(1))
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                        }
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) { day in
                            if day.monthInt != date.monthInt {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                            } else {
                                Button(action: {
                                    date = Calendar.current.startOfDay(for: day)
                                }){
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.blue)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Circle()
                                                .foregroundStyle(
                                                    Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: day)
                                                    ? Color.red.opacity(0.3) : Color.blue.opacity(0)
                                                )
                                        )
                                }
                            }
                        }
                    }
                    NavigationLink("Go to weekly view", destination: WeeklyView(date: $date))
                        .padding(.vertical, 8)
                }.padding(.horizontal, 12)
                
            }
            .padding(.top, 40)
            .onAppear() {
                days = date.calendarDisplayDays
            }
            .onChange(of: date) {
                days = date.calendarDisplayDays
            }
            Spacer()
            
        }
    }
}

