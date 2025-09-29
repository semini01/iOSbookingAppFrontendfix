//
//  TourGuideView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-22.
//


import SwiftUI

struct TourGuideView: View {
    
    @State private var selectedGuide: Guide? = nil
    
    let guides: [Guide] = [
        Guide(
            name: "John Silva",
            specialty: "Colombo City Tour",
            rating: 4.8,
            image: "person.crop.circle.fill",
            tours: [
                Tour(title: "Colombo Half-Day Tour", price: 50, timeSlots: ["9:00 AM", "2:00 PM"]),
                Tour(title: "Colombo Night Tour", price: 70, timeSlots: ["7:00 PM"])
            ]
        ),
        Guide(
            name: "Amara Perera",
            specialty: "Cultural & Temple Tours",
            rating: 4.7,
            image: "person.crop.circle.fill",
            tours: [
                Tour(title: "Temple of the Tooth", price: 80, timeSlots: ["8:00 AM", "1:00 PM"]),
                Tour(title: "Sigiriya Day Trip", price: 120, timeSlots: ["6:00 AM"])
            ]
        ),
        Guide(
            name: "Ruwan Fernando",
            specialty: "Wildlife & Nature",
            rating: 4.9,
            image: "person.crop.circle.fill",
            tours: [
                Tour(title: "Yala Safari", price: 150, timeSlots: ["5:30 AM"]),
                Tour(title: "Sinharaja Rainforest", price: 100, timeSlots: ["7:00 AM"])
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Tour Guides")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        ForEach(guides) { guide in
                            GuideCard(guide: guide) {
                                selectedGuide = guide
                            
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedGuide) { guide in
                ScheduleView(guide: guide)
            }
        }
    }
}


#Preview {
    TourGuideView()
}
