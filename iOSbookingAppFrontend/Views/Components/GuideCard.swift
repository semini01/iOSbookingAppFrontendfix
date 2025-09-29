//
//  GuideCard.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-28.
//

import SwiftUI

struct GuideCard: View {
    let guide: Guide
    let onScheduleTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: guide.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6) {
                Text(guide.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(guide.specialty)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                    Text(String(format: "%.1f", guide.rating))
                        .foregroundColor(.white)
                }
            }
            Spacer()
            
            Button("Schedule", action: onScheduleTap)
                .font(.subheadline.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.05))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    GuideCard(
        guide: Guide(
            name: "Preview Guide",
            specialty: "Test Specialty",
            rating: 4.5,
            image: "person.crop.circle.fill",
            tours: []
        )
    ) {
        print("Schedule tapped")
    }
}

