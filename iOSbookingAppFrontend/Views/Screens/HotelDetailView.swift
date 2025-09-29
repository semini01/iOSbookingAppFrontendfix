////
////  HotelDetailView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-11.
//
import SwiftUI
import MapKit

struct HotelDetailView: View {
    let hotel: Hotel
    //    var descriptionText: String {
    //            """
    //            Welcome to \(hotel.name), located in the heart of \(hotel.city).
    //            Enjoy premium facilities, spacious rooms, and an unforgettable stay with world-class service.
    //            """
    //        }
  //  @EnvironmentObject var tabState: TabState 
    @State private var pulse = false
    @State private var showRooms = false
    @State private var selectedRoomId: String? = nil
    
    @State private var animateButton = false
    
    @StateObject private var roomVM = RoomTypeViewModel()
    
    @State private var goToConfirmation = false
    @State private var selectedBooking: Booking?
    
    @State private var checkInDate: Date = Date()
    @State private var checkOutDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @StateObject private var bookingVM = BookingViewModel()
    private let eventKitManager = EventKitManager()
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                //  Hotel Name
                Text(hotel.name)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                //  Hotel Image
                if let imageUrl = hotel.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 220)
                            .overlay(ProgressView())
                            .padding(.horizontal)
                    }
                }
                
                //  Address (using city for now)
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    Text(hotel.city ?? "Unknown City")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
               
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        let ratingValue = Int((hotel.rating ?? 0).rounded())
                        ForEach(0..<5, id: \.self) { index in
                            let filled = index < ratingValue
                            Image(systemName: filled ? "star.fill" : "star")
                                .foregroundColor(filled ? .yellow : .gray)
                                .font(.caption)
                        }
                        
                        Text(String(format: "%.1f", hotel.rating ?? 0.0))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    
                    Text("$\(hotel.price ?? 0) / night")
                        .foregroundColor(.orange)
                        .font(.headline)
                }
                .padding(.horizontal)
                
                Divider().background(Color.gray.opacity(0.6))
                    .padding(.horizontal)
                
                //  Facilities
                if let facilities = hotel.facilities, !facilities.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Facilities")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(facilities, id: \.self) { facility in
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(facility)
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                Divider().background(Color.gray.opacity(0.6))
                    .padding(.horizontal)
                
                
                
                Button(action: {
                    showRooms.toggle()
                }) {
                    HStack {
                        
                        Text("View Room Types")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                       
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding()
                    .frame(height: 55)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
                    
                    .scaleEffect(pulse ? 1.02 : 1.0)
                    .shadow(color: Color.gray.opacity(0.4), radius: pulse ? 10 : 4, x: 0, y: 3)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                            pulse.toggle()
                        }
                    }
                }
                .padding(.horizontal)
                
                BookingDatesView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                
                
                //  Map
                VStack(alignment: .leading, spacing: 8) {
                                    Text("Location")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Map(initialPosition: .region(
                                        MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        )
                                    )) {
                                        Marker(
                                            hotel.name ,
                                            coordinate: CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
                                        )
                                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
                
                
                Button(action: {
                    handleBooking()
                }) {
                    Text("Book Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                
                Button(action: {
                    openInMaps(hotel: hotel)
                }) {
                    HStack {
                        Image(systemName: "car.fill")
                        Text("Get Directions")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
            }
            
        }
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showRooms) {
            RoomTypesView(hotelId: hotel.id, selectedRoomId: $selectedRoomId)
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Booking"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
            
        }
            
        }
        
        
       
        func openInMaps(hotel: Hotel) {
            let coordinate = CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = hotel.name
            mapItem.openInMaps(launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ])
        }
        
    private func handleBooking() {
       
        guard let roomId = selectedRoomId else {
            alertMessage = "Please select a room type."
            showAlert = true
            return
        }
        
        guard checkInDate < checkOutDate else {
            alertMessage = "Check-Out must be after Check-In."
            showAlert = true
            return
        }
        
       
        let bookingData: [String: Any] = [
            "hotelId": hotel.id,
            "roomId": roomId,
            "checkInDate": ISO8601DateFormatter().string(from: checkInDate),
            "checkOutDate": ISO8601DateFormatter().string(from: checkOutDate)
        ]
        
        
        bookingVM.createBooking(bookingData) { backendBooking in
           
            let finalBooking = backendBooking ?? Booking(
                id: UUID().uuidString,
                hotelId: hotel.id,
                roomId: roomId,
                checkInDate: checkInDate,
                checkOutDate: checkOutDate,
                hotelName: hotel.name,
                location: hotel.city
            )
            
            eventKitManager.requestAccess { granted in
                if granted {
                    eventKitManager.addBookingEvent(finalBooking)
                    print(" Event added to Calendar for \(finalBooking.hotelName ?? "Hotel")")
                }
            }
            
            //Schedule local notification with log
            NotificationManager.shared.sendBookingNotification(for: finalBooking)
            print("Notification scheduled for booking at \(finalBooking.hotelName ?? "Unknown Hotel")")
            
            alertMessage = "Booking successful!"
            showAlert = true
        }
    }
    }

#Preview {
        HotelDetailView(
            hotel: Hotel(
                id: "1",
                name: "Marino Beach Hotel",
                city: "Colombo",
                rating: 4.5,
                price: 120,
                imageUrl: "https://picsum.photos/400/300",
                latitude: 6.9271,
                longitude: 79.8612,
                facilities: ["WiFi", "Pool", "Gym", "Spa"]
            )
        )
    }
