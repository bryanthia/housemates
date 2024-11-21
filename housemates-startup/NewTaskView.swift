//
//  NewTaskView.swift
//  housemates
//
//  Created by Bryan Thia on 3/11/2024.
//

import SwiftUI

struct NewTaskView: View {
    /// View Properties
    @Environment(\.dismiss) private var dismiss
    @State var taskTitle: String = ""
    @State var taskDate: Date = .init()
    @Binding var isTaskCategoryView: Bool // Track the currently displayed view

    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15){
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                        isTaskCategoryView = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .tint(.red)
                        
                    })
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Go for a Walk!", text: $taskTitle)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                }
                .padding(.top, 5)
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Task Date")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                    }
                    // giving some space for tapping
                    .padding(.trailing, -15)
                    
                }
                .padding(.top, 5)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Text("Create Task")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .textScale(.secondary)
                            .foregroundStyle(.black)
                            .padding(.vertical, 12)
                    })
                    .disabled(taskTitle == "")
                    .opacity(taskTitle == "" ? 0.5 : 1)
                    Spacer()
                }
            }
            .padding(15)
        }
    }
}
