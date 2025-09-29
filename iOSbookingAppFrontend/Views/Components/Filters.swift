//
//  Filters.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-26.
//

import SwiftUI

struct Filters: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.white.opacity(0.15))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}
