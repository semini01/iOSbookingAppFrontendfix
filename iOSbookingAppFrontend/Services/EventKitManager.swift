//
//  EventKitManager.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


import EventKit

class EventKitManager {
    let eventStore = EKEventStore()
    
    //to request calender access
    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestFullAccessToEvents { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func addBookingEvent(_ booking: Booking) {
        let event = EKEvent(eventStore: eventStore)
        event.title = "Stay at \(booking.hotelName ?? "Unknown Hotel")"
        
        event.location = booking.location
        event.startDate = booking.checkInDate
        event.endDate = booking.checkOutDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print(" Booking added to Calendar")
        } catch {
            print("Error saving event: \(error.localizedDescription)")
        }
    }
    
    func addTourEvent(tourName: String, guideName: String, date: Date, timeSlot: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        // Extract hour/minute from the time slot
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        if let slotDate = formatter.date(from: timeSlot) {
            let slotComps = Calendar.current.dateComponents([.hour, .minute], from: slotDate)
            comps.hour = slotComps.hour
            comps.minute = slotComps.minute
        }
        
        guard let startDate = Calendar.current.date(from: comps) else {
            print("Could not parse slot \(timeSlot)")
            return
        }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = "\(tourName) with \(guideName)"
        event.startDate = startDate
        event.endDate = startDate.addingTimeInterval(2 * 3600)
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("Tour added to Calendar")
        } catch {
            print(" Error saving tour: \(error.localizedDescription)")
        }
    }
    
}
