//
//  BookingHistoryView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-23.
//


import SwiftUI
import CoreData

struct BookingHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookingEntity.checkInDate, ascending: true)],
        animation: .default
    ) private var bookings: FetchedResults<BookingEntity>
    
    var body: some View {
        NavigationView {
            List {
              
                Section(header: Text("Upcoming")) {
                    ForEach(upcomingBookings, id: \.objectID) { booking in
                        BookingRow(booking: booking)
                    }
                }
                
                
                Section(header: Text("Past")) {
                    ForEach(upcomingBookings, id: \.objectID) { booking in
                        BookingRow(booking: booking)
                    }
                }
            }
            .navigationTitle("Booking History")
        }
    }
    

    private var upcomingBookings: [BookingEntity] {
        bookings.filter { ($0.checkInDate ?? Date()) >= Date() }
    }
    
    private var pastBookings: [BookingEntity] {
        bookings.filter { ($0.checkOutDate ?? Date()) < Date() }
    }
}
