//
//  WeeklyView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 16/11/2024.
//

import SwiftUI

struct WeeklyView: View {
    @StateObject var viewModel = TaskViewModel()
    @Binding var date: Date
    @State var fullCalendarShown: Bool = false
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                        Spacer()
                        Image("mw")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .cornerRadius(60)
                    }
                    .padding(24)
                    .padding(.top, 40)
                    
                    
                    HStack(alignment: .center) {
                        Text("\(date, format: Date.FormatStyle().month(.wide))")
                            .font(.title)
                            .fontWeight(.bold)
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                fullCalendarShown.toggle()
                                days = fullCalendarShown ? date.calendarDisplayDays : date.allWeekDays
                            }
                                                        
                        }) {
                            fullCalendarShown ? Image(systemName: "arrow.down.forward.and.arrow.up.backward") :
                            Image(systemName: "arrow.down.backward.and.arrow.up.forward")
                        }
                        Spacer()
                        HStack(alignment: .center) {
                            Button(action: {
                                date = Calendar.current.date(byAdding: .day, value: -date.startOfPreviousMonth.numberOfDaysInMonth, to: date)!
                            }) {
                                Image(systemName: "arrow.left")
                            }
                            
                            Button(action: {
                                date = Calendar.current.startOfDay(for: Date.now)
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
                    
                    HStack() {
                        ForEach(Date.daysInAWeek, id: \.self) { day in
                            Text(day.prefix(1))
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
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
                        .transition(.move(edge: .top))



                        .padding(.bottom, 18)
                        .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))
                        .padding(.horizontal, 12)
                        .transition(.move(edge: .top))
                    

                }
                .background(Color.white)
                .cornerRadius(40)
                
                HStack {
                    NavigationLink("Go to monthly view", destination: MonthlyView(date: date))
                        .padding(.vertical, 8)
                    NavigationLink("Go to daily view", destination: DailyView(date: $date))
                        .padding(.vertical, 8)
                }
                VStack (alignment: .leading){
                    ScrollView {
                        ForEach(viewModel.getTasks(for: date), id: \.id) { task in
                            HStack {
                                VStack (alignment: .leading){
                                    Text("\(task.time, format: Date.FormatStyle().hour().minute()) - \(task.endTime, format: Date.FormatStyle().hour().minute())")
                                        .font(.caption2)
                                        .padding(.bottom, 2)
                                    Text(task.title)
                                        .font(.title3)
                                        .fontWeight(.bold)

                                    Spacer()
                                    HStack(alignment: .center) {
                                        Text("Today")
                                            .font(.footnote)
                                            .padding(12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                                    .fill(Color.gray.opacity(0.3))
                                            )
                                        
                                        Text("\(task.formattedDuration)")
                                            .font(.footnote)
                                            .padding(12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                                    .fill(Color.gray.opacity(0.3))
                                            )
                                        Spacer()
                                        Image(systemName: "paperplane")
                                            .foregroundStyle(.white)
                                            .padding(12)
                                            .background(
                                                Circle()
                                                    .fill(Color.black)
                                            )
                                    }
                                    .padding(.top, 24)
                                }
                                .padding(24)
                                
                                
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(30)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                        }
                        
                    }
                    
                }
                Spacer()
            }
            .ignoresSafeArea()
            
            .background(Color.black)
            .onAppear() {
                days = date.allWeekDays
            }
            .onChange(of: date) {
                if (fullCalendarShown) {
                    days = date.calendarDisplayDays
                } else {
                    days = date.allWeekDays
                }
            }

        }
        .navigationBarBackButtonHidden(true)
    }
}
