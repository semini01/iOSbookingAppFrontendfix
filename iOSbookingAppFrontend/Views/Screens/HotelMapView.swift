////
////  HotelMapView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-17.
//
import SwiftUI
import MapKit

struct HotelMapView: View {
    @StateObject private var hotelVM = HotelViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612), // Colombo
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var selectedHotel: Hotel?
    
  

    
    var body: some View {
        ZStack {
            if hotelVM.isLoading {
                ProgressView("Loading hotels...")
            } else if let error = hotelVM.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Map(initialPosition: .region(
                                    MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612), // Colombo
                                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                                    )
                                ))
                { ForEach(hotelVM.hotels) { hotel in
                    Annotation(hotel.name, coordinate: hotel.coordinate) {
                        VStack(spacing: 4) {
                            CustomRedPin()
                            Text(hotel.name)
                                .font(.caption2)
                                .foregroundColor(.black)
                                .fixedSize()
                        }
                        .onTapGesture {
                            selectedHotel = hotel
                        }
                    }
                }
                    UserAnnotation()
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            hotelVM.fetchHotels()
        }
        .sheet(item: $selectedHotel) { hotel in
            HotelDetailView(hotel: hotel)
        }
    }
}
