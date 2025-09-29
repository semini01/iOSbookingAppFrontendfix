////
////  LoginView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-06.
//

//BGLogin

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var isLoggedIn = false
    @State private var faceIDStatus: String? = nil
    
    let fieldWidth: CGFloat = 320
    let fieldHeight: CGFloat = 50
    
    var body: some View {
        NavigationStack {
            ZStack {
               
                Image("BGLogin")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.5).ignoresSafeArea()
                
                VStack(spacing: 18) {
                    
                    Text("Welcome to EliteStay")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    
                    Spacer()
                    
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                        TextField(
                            "",
                            text: $email,
                            prompt: Text("Enter Your email")
                                .foregroundColor(.gray)
                        )
                        .foregroundColor(.white)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    }
                    .padding()
                    .frame(width: fieldWidth, height: fieldHeight)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    
                   
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        if isPasswordVisible {
                            TextField(
                                "",
                                text: $password,
                                prompt: Text("Enter Your Password")
                                    .foregroundColor(.gray)
                            )
                            .foregroundColor(.white)
                        } else {
                            SecureField(
                                "",
                                text: $password,
                                prompt: Text("Enter Your Password")
                                    .foregroundColor(.gray)
                            )
                            .foregroundColor(.white)
                        }
                                 
                    }
                    .padding()
                    .frame(width: fieldWidth, height: fieldHeight)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    
                    
                    .padding()
                    
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                
                    Button {
                        login()
                    } label: {
                        Text(isLoading ? "Loading..." : "Sign In")
                            .frame(width: fieldWidth, height: fieldHeight)
                            .background(Color.white.opacity(0.25))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(isLoading)
                    //  .padding(.top, 10)
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("Don’t have an account?")
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                    .font(.footnote)
                    .padding(.top, 5)
                    
                    // Spacer()
                    .padding()
                    
                    Button {
                        authenticateWithBiometrics { success in
                            if success { if let savedToken = KeychainHelper.shared.getToken() {
                                print("Logged in with Face ID, token: \(savedToken)")
                                self.isLoggedIn = true
                            } else {
                                print(" No saved token found. Please log in with credentials first.")
                                self.errorMessage = "No saved login found. Please sign in with email & password."
                            }
                            } else {
                                self.errorMessage = "Face ID authentication failed."
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "faceid")
                            Text("Use Face ID")
                        }
                        .frame(width: fieldWidth, height: fieldHeight)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    
                    
                    if let faceIDStatus = faceIDStatus {
                        Text(faceIDStatus)
                            .foregroundColor(faceIDStatus.contains("done face id") ? .green : .red)
                            .font(.subheadline)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .padding(.top, 60)
                
                NavigationLink("", destination: DashboardView(), isActive: $isLoggedIn)
                    .hidden()
                
//                    .navigationDestination(isPresented: $isLoggedIn) {
//                            DashboardView()
            }
        }
    }
    
    private func login() {
        isLoading = true
        errorMessage = nil
        APIService.shared.login(email: email, password: password) { result in
                   DispatchQueue.main.async {
                       self.isLoading = false
                       switch result {
                       case .success(let token):
                           print(" Logged in, token: \(token)")
                           KeychainHelper.shared.saveToken(token)   // Save securely
                           self.isLoggedIn = true

                       case .failure(let error):
                           print(" Login failed: \(error.localizedDescription)")
                           self.errorMessage = "Login failed: \(error.localizedDescription)"
                       }
                   }
               }
           }
           
    }
    
    
    private func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Log in with Face ID") { success, _ in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            completion(false)
        }
    }

#Preview {
    LoginView()
}
