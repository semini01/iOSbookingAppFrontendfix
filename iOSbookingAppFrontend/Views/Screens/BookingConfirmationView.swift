//
//  BookingConfirmationView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


import SwiftUI

struct BookingConfirmationView: View {
    let booking: Booking
    
    @State private var eventKitManager = EventKitManager()
    @State private var hasAccess = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Booking Confirmed at \(booking.hotelName ?? "Unknown Hotel")")
                .font(.title2)
                .padding(.top)
            
            Text("City: \(booking.location ?? "Unknown")")
            Text("Check-in: \(booking.checkInDate.formatted())")
            Text("Check-out: \(booking.checkOutDate.formatted())")
            
            Button {
                eventKitManager.requestAccess { granted in
                    if granted {
                        eventKitManager.addBookingEvent(booking)
                        hasAccess = true
                    } else {
                        hasAccess = false
                    }
                }
            } label: {
                Label("Add to Calendar", systemImage: "calendar.badge.plus")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if hasAccess {
                Text(" Added to Calendar").foregroundColor(.green)
            }
        }
        .padding()
    }
}
