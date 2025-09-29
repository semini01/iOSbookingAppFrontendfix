//
//  ScheduleView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-28.
//


import SwiftUI

struct ScheduleView: View {
    let guide: Guide
    @State private var selectedTour: Tour? = nil
    @State private var selectedTime: String? = nil
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                
                TourList(
                                    guide: guide,
                                    selectedTour: $selectedTour,
                                    selectedTime: $selectedTime
                                )
            }
            .navigationTitle("\(guide.name)'s Tours")
            .toolbar {
                if let tour = selectedTour, let time = selectedTime {
                    Button("Book") {
                      
                        let formatter = DateFormatter()
                        formatter.dateFormat = "h:mm a"
                        var comps = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
                        
                        if let slotDate = formatter.date(from: time) {
                            let slotComps = Calendar.current.dateComponents([.hour, .minute], from: slotDate)
                            comps.hour = slotComps.hour
                            comps.minute = slotComps.minute
                        }
                        
                        let date = Calendar.current.date(from: comps) ?? selectedDate
                        
                        
                        EventKitManager().addTourEvent(
                            tourName: tour.title,
                            guideName: guide.name,
                            date: selectedDate,
                            timeSlot: time
                        )

                        
                        
                        NotificationManager.shared.sendTourNotification(
                            tour: tour.title,
                            guide: guide.name,
                            time: time
                        )
                        
                        print("Booked \(tour.title) at \(time) on \(selectedDate) with \(guide.name)")
                    }
                }
            }
            .onAppear {
                EventKitManager().requestAccess { _ in }
                NotificationManager.shared.requestPermission()
            }
        }
    }
    
}
