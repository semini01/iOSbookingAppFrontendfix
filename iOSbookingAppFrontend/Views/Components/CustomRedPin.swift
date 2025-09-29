//
//  CustomRedPin.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-27.
//

import SwiftUI
import MapKit

struct CustomRedPin: View {
    var body: some View {
        VStack(spacing: 0) {
            // Pin head
            Circle()
                .fill(Color.red)
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 10, height: 10)
                        .offset(x: 6, y: -6),
                    alignment: .topTrailing
                )
            
            // Pin stick
            Rectangle()
                .fill(Color.black)
                .frame(width: 3, height: 30)
        }
        .shadow(radius: 3)
    }
}

#Preview {
    CustomRedPin()
}
