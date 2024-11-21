//
//  DailyView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 17/11/2024.
//

import SwiftUI

struct DailyView: View {
    @Binding var date: Date
    var body: some View {
        NavigationStack {
            VStack {
               
                HStack {
                    Text("\(Date.daysInAWeek[Calendar.current.component(.weekday, from: date)])")
                    Spacer()
                    Text("\(date, format: Date.FormatStyle().day().month().year())")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Button(action: {
                            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        
                        Button(action: {
                            date = Calendar.current.startOfDay(for: Date.now)
                        }) {
                            Image(systemName: "house")
                        }
                        
                        Button(action: {
                            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        }) {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal, 16)
            }
            Spacer()
        }
    }
}
