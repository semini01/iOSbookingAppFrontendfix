//
//  TourSection.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


import SwiftUI

struct TourSection: View {
    let tour: Tour
    @Binding var selectedTour: Tour?
    @Binding var selectedTime: String?
    
    var body: some View {
        Section(header: Text(tour.title).font(.headline)) {
            Text("Price: $\(String(format: "%.0f", tour.price))")
                .foregroundColor(.red)
            
            ForEach(tour.timeSlots, id: \.self) { slot in
                Button {
                    selectedTour = tour
                    selectedTime = slot
                } label: {
                    HStack {
                        Text(slot)
                        Spacer()
                        if selectedTour?.id == tour.id && selectedTime == slot {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TourSection(
        tour: Tour(title: "Colombo Night Tour", price: 70, timeSlots: ["7:00 PM"]),
        selectedTour: .constant(nil),
        selectedTime: .constant(nil)
    )
}
