//
//  AuthenticationView.swift
//  housemates-startup
//
//  Created by Bryan Thia on 21/11/2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


// TODO: view swiftful thinking
@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Sign In with email", destination: SignInView(showSignInView: $showSignInView))
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do{
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                            
                        }
                    }
                    
                }
            }
            
            
            
            
        }
    }
}
