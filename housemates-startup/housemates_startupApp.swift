//
//  housemates_startupApp.swift
//  housemates-startup
//
//  Created by Bryan Thia on 14/11/2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct housemates_startupApp: App {
    init() {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        print("configured")
    }
    var body: some Scene {
        WindowGroup {
//            MonthlyView(date: Calendar.current.startOfDay(for: Date.now))
            RootView()
        }
    }
}
