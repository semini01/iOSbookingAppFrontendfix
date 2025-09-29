//
//  AnimatedGlassButton.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-25.
//

import SwiftUI

struct AnimatedGlassButton: View {
    var title: String
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var action: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                action()
            }
        }) {
            Text(title)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .background(.ultraThinMaterial) 
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .scaleEffect(isAnimating ? 1.02 : 1.05)
                .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                           value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    AnimatedGlassButton(
        title: "Get Started",
        width: 240,
        height: 55,
        cornerRadius: 14,
        fontSize: 18,
        fontWeight: .medium
    ) {
        print(" Get Started")
    }
}
