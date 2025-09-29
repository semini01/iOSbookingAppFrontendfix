//
//  BookingRow.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-24.
//


import SwiftUI
import CoreData

struct BookingRow: View {
    let booking: BookingEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(booking.hotelName ?? "Unknown Hotel")
                .font(.headline)
            HStack {
                Text("Check-in: \(format(booking.checkInDate))")
                Text("Check-out: \(format(booking.checkOutDate))")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
    
    private func format(_ date: Date?) -> String {
        guard let date else { return "N/A" }
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}
