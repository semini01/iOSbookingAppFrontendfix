//
//  WelcomeView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-07.

import SwiftUI

struct WelcomeView: View {
    
    @State private var isAnimating = false
    @State private var showWelcomeView = false
    
    var body: some View {
        ZStack {
            
           
            Image("BGimageForWelcomeScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
               
                
                VStack(spacing: 10) {
                   
                    
                    Image(systemName: "building.2.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .shadow(radius: 8)
                        .scaleEffect(isAnimating ? 1.0 : 0.8)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                                   value: isAnimating)
                    
                    // Title
                    Text("Welcome to EliteStay")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                        .scaleEffect(isAnimating ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                                   value: isAnimating)
                    
                    // Subtitle
                    Text("Find and book your perfect stay with ease")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 20)
                
                Spacer()
                
                
                AnimatedGlassButton(
                    title: "Get Started",
                    width: 240,
                    height: 55,
                    cornerRadius: 14,
                    fontSize: 18,
                    fontWeight: .medium
                ) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showWelcomeView  = true
                    }
                }
            .padding(.bottom, 70)
                .scaleEffect(isAnimating ? 1.02 : 1.05)
                .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                           value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showWelcomeView = true
                }
            }
        }
        .fullScreenCover(isPresented: $showWelcomeView ) {
            LoginView()
        }
    }
}

#Preview {
    WelcomeView()
}
