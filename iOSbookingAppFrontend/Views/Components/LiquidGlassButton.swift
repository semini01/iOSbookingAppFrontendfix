//
//  AnimatedButtonStyle.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-26.
//

import SwiftUI

struct LiquidGlassButtonStyle: ButtonStyle {
    @State private var shimmerOffset: CGFloat = -1.0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                ZStack {
                  
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                    
                   
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.25),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 250
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.15),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    
                    // 4. Shimmer gradient sweep
                    // Thin shimmer sweep (white highlight)
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            Color.white.opacity(0.8),
                            .clear
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(width: 12, height: 200)
                    .blur(radius: 2)
                    .rotationEffect(.degrees(20))
                    .offset(x: shimmerOffset * 300)


                }
            )
            .overlay(enhancedBorder)
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(color: .white.opacity(0.4), radius: 8, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .onAppear {
                startShimmerAnimation()
            }
    }
    
    //Enhanced glowing border
    private var enhancedBorder: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.8),
                        Color.white.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1.5
            )
    }
    
    // Shimmer animation
    private func startShimmerAnimation() {
        withAnimation(
            Animation.linear(duration: 2.5)
                .repeatForever(autoreverses: false)
        ) {
            shimmerOffset = 1.0
        }
    }
}
