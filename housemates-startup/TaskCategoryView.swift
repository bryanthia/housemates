//
//  TaskCategoryView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 18/11/2024.
//

import SwiftUI

struct TaskCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isTaskCategoryView: Bool // Track the currently displayed view

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Text("New Task")
                        .fontWeight(.bold)
                    Spacer()
                    
                }
                .overlay(alignment: .trailing) {
                    Button(action: {
                        dismiss()
                        isTaskCategoryView = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .tint(.red)
                        
                    })
                }
                .padding(.top, 15)
                
                
                Spacer()
                Text("Book A Space")
                    .padding(15)
                    .frame(maxWidth: 200)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                Spacer()
                Text("Schedule chore")
                    .padding(15)
                    .frame(maxWidth: 200)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                Spacer()
                
                
                Button(action: {
                        
                        isTaskCategoryView.toggle()
                    
                }){
                    Text("Add an event")
                        .padding(15)
                        .frame(maxWidth: 200)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                }
                Spacer()
            }
            

            .padding(15)

        }
    }
               
}
