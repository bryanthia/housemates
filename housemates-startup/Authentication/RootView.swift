//
//  RootView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 21/11/2024.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    SettingsView(showSignInView: $showSignInView)
                }
                
            }
            
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticaredUser()
            self.showSignInView = authUser == nil
            
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
            
        }
    }
}

#Preview {
    RootView()
}
