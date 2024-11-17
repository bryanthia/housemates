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
                            fullCalendarShown.toggle()
                            print(fullCalendarShown)
                        }) {
                            fullCalendarShown ? Image(systemName: "arrow.down.forward.and.arrow.up.backward") :
                            Image(systemName: "arrow.down.backward.and.arrow.up.forward")
                        }
                        Spacer()
                        HStack(alignment: .center) {
                            Button(action: {
                                date = Calendar.current.date(byAdding: .day, value: -7, to: date)!
                            }) {
                                Image(systemName: "arrow.left")
                            }
                            
                            Button(action: {
                                date = Date.now
                            }) {
                                Image(systemName: "house")
                            }
                            
                            Button(action: {
                                date = Calendar.current.date(byAdding: .day, value: 7, to: date)!
                            }) {
                                Image(systemName: "arrow.right")
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 16)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0){
                            ForEach(0..<7, id: \.self) { day in
                                VStack {
                                    Text("\(Date.daysInAWeek[day])")
                                        .font(.subheadline)
                                        .padding(.top, 6)
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            date = date.sundayOfWeek.addToDate(numDays: day)
                                        }
                                    }) {
                                        Text(date.sundayOfWeek.addToDate(numDays: day), format: Date.FormatStyle().day())
                                            .foregroundColor(Color.black)
                                            .font(.headline)
                                            .frame(maxWidth: .infinity)
                                            .padding(8)
                
                                    }
                                }
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .foregroundStyle(
                                            Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: date.sundayOfWeek.addToDate(numDays: day))
                                            ? Color.red.opacity(0.3) : Color.red.opacity(0)
                                        )
                                )
                                .padding(4)
                                
                            }
                        }
                        .padding(4)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0))
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))

                    .padding(.horizontal, 12)
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
                                    Text("15:00 - 16:00")
                                        .font(.caption2)
                                        .padding(.bottom, 2)
                                    Text(task.title)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    Text(task.description)
                                        .font(.footnote)
                                    Spacer()
                                    HStack(alignment: .center) {
                                        Text("Today")
                                            .font(.footnote)
                                            .padding(12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                                    .fill(Color.gray.opacity(0.3))
                                            )
                                        
                                        Text("1h")
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
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
