//
//  Task.swift
//  housemates-startup
//
//  Created by Bryan Thia on 17/11/2024.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}
