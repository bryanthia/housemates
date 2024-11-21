//
//  SettingsView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 21/11/2024.
//

import SwiftUI
@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticaredUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "newemail@gmsil.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "12345678"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}
struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            List {
                Button("Log out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                    
                }
                
                Button(role: .destructive){
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            showSignInView = true
                        } catch {
                            print(error)
                            
                        }
                    }
                    
                } label: {
                    Text("Delete Account")
                    
                }
                if viewModel.authProviders.contains(.email) {
                    emailSection
                }
            }
            .onAppear {
                viewModel.loadAuthProviders()
            }
        }
    }
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASS RESEt")
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
                
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASS updated")
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
                
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("email updated")
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
                
            }
        } header: {
            Text("email funcs")
        }
    }
}

