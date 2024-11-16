//
//  WeeklyView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 16/11/2024.
//

import SwiftUI

struct WeeklyView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(Date.daysInAWeek, id: \.self) { day in
                        VStack {
                            Text(day)
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                            Text("hi")
                                .padding(12)
                            
                        }
                    }
                }
                .padding(12)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .padding(.horizontal, 12)

            
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    WeeklyView()
}
