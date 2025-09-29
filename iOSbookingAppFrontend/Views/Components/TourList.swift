//
//  TourList.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


import SwiftUI

struct TourList: View {
    let guide: Guide


    @Binding var selectedTour: Tour?
    @Binding var selectedTime: String?
    
    var body: some View {
        List {
            ForEach(guide.tours) { tour in
                TourSection(
                    tour: tour,
                    selectedTour: $selectedTour,
                    selectedTime: $selectedTime
                )
            }
        }
    }
}

#Preview {
    TourList(
        guide: Guide(
            name: "John Silva",
            specialty: "City Tours",
            rating: 4.8,
            image: "person.crop.circle.fill",
            tours: [
                Tour(title: "Colombo Half-Day Tour", price: 50, timeSlots: ["9:00 AM", "2:00 PM"]),
                Tour(title: "Colombo Night Tour", price: 70, timeSlots: ["7:00 PM"])
            ]
        ),
        selectedTour: .constant(nil),
        selectedTime: .constant(nil)
    )
}
