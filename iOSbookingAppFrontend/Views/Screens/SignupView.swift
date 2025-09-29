////
////  SignupView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-06

import SwiftUI

struct SignUpView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var isSignedUp = false
    @State private var animateShine = false
    
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
                    
                    Text("Create Account")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Spacer()
                    
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white.opacity(0.8))
                        TextField("", text: $name,
                                  prompt: Text("Enter Your Name")
                            .foregroundColor(.white.opacity(0.8))
                                  )
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.words)
                    }
                    .padding()
                    .frame(width: fieldWidth, height: fieldHeight)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white.opacity(0.8))
                        TextField("", text: $email,
                                  prompt: Text("Enter Your Email")
                            .foregroundColor(.white.opacity(0.8))
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
                            .foregroundColor(.white.opacity(0.8))
                        if isPasswordVisible {
                            TextField("", text: $password,
                                      prompt: Text("Enter Your Password")
                                .foregroundColor(.white.opacity(0.8))
                                      )
                                .foregroundColor(.white)
                        } else {
                            SecureField("", text: $password,
                                        prompt: Text("Enter Your Password")
                                .foregroundColor(.white.opacity(0.8)))
                                .foregroundColor(.white)
                        }
                    
                    }
                    .padding()
                    .frame(width: fieldWidth, height: fieldHeight)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    
                Spacer()
                    
                   
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                  
                    Button {
                        signUp()
                    } label: {
                        Text(isLoading ? "Loading..." : "Sign Up")
                            .fontWeight(.semibold)

                         
                            .foregroundColor(.white)
                    }
                    .buttonStyle(LiquidGlassButtonStyle())
                    .disabled(isLoading)
                    .frame(width: fieldWidth, height: fieldHeight)
                    

                    
                    Spacer()
                    
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                    .font(.footnote)
                    .padding(.top, 5)
                    
                    Spacer()
                }
                .padding(.top, 60)
                
                
                NavigationLink("", destination: DashboardView(), isActive: $isSignedUp)
                    .hidden()
            }
        }
    }
    
    
    private func signUp() {
        isLoading = true
        errorMessage = nil
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            self.errorMessage = "All fields are required."
            self.isLoading = false
            return
        }
        

        
        APIService.shared.signup(name: name, email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let token):
                    print(" Signed up, token: \(token)")
                    KeychainHelper.shared.saveToken(token) // save securely
                    self.isSignedUp = true                // navigate to dashboard
                case .failure(let error):
                    print("Signup failed: \(error.localizedDescription)")
                    self.errorMessage = "Signup failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
