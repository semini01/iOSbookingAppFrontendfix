//
//  DashboardView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-07.
//


import SwiftUI

struct DashboardView: View {
    @State private var searchText = ""
    @StateObject private var hotelVM = HotelViewModel()
    @State private var showMap = false

    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                       
                        Text("EliteStay")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        SearchBar(
                                                    placeholder: "Search Hotels, Cities...",
                                                    text: $searchText,
                                                    onSearch: {
                                                        
                                                        print("Searching for \(searchText)")
                                                    }
                                                )
                        
                        // Filters Row
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                Filters(title: " 4.5+") { searchText = "4.5" }
                                Filters(title: "Colombo") { searchText = "Colombo" }
                                Filters(title: "WiFi") { searchText = "WiFi" }
                                Filters(title: "Pool") { searchText = "Pool" }
                            }
                            .padding(.vertical, 4)
                        }
                        
                        // Sort Menu
                        Menu {
                            Button("Price: Low to High") {
                                hotelVM.hotels.sort { ($0.price ?? 0) < ($1.price ?? 0)  }
                            }
                            Button("Price: High to Low") {
                                hotelVM.hotels.sort { ($0.price ?? 0) < ($1.price ?? 0) }
                            }
                            Button("Top Rated") {
                                hotelVM.hotels.sort { ($0.rating ?? 0.0) > ($1.rating ?? 0.0) }
                            }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                                .foregroundColor(.white)
                        }
                        
                        // Top Rated Hotels
                        Text("Top Rated")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                LazyHStack(spacing: 20) {
                                    ForEach(hotelVM.hotels.filter { ($0.rating ?? 0.0) >= 4.5 }) { hotel in
                                        
                                            NavigationLink(destination: HotelDetailView(hotel: hotel)) {
                                                HotelCardView(hotel: hotel)
                                                .frame(width: 380)
                                              
                                                .cornerRadius(15)
                                               .padding(.vertical, 1)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        
                        // Featured Hotels
                        Text("Featured Hotels")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        if hotelVM.isLoading {
                            ProgressView("Loading hotels...")
                                .foregroundColor(.white)
                        } else if let error = hotelVM.errorMessage {
                            Text("warning \(error)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            ScrollView (.horizontal, showsIndicators: false){
                                LazyVStack(spacing: 16) {
                                    ForEach(hotelVM.hotels.filter { hotel in
                                        searchText.isEmpty ||
                                        hotel.name.localizedCaseInsensitiveContains(searchText) ||
                                       ( hotel.city ?? "").localizedCaseInsensitiveContains(searchText) ||
                                        hotel.facilities?.contains(where: { $0.localizedCaseInsensitiveContains(searchText) }) == true
                                    }) { hotel in
                                        NavigationLink(destination: HotelDetailView(hotel: hotel)) {
                                                HotelCardView(hotel: hotel)
                                                  //  .padding(.horizontal, 12)
                                                    .frame(width: 380)
                                            .cornerRadius(12)}
                                    .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.bottom, 80)
                            }
                        }
                        
                       

                        NavigationLink(destination: TourGuideView()) {
                                                   HStack {
                                                       Image(systemName: "person.fill.viewfinder")
                                                       Text("Book Tour Guide")
                                                           .fontWeight(.semibold)
                                                   }
                                                   .frame(maxWidth: .infinity)
                                                   .padding()
                                                   .background(Color.blue)
                                                   .foregroundColor(.white)
                                                   .cornerRadius(12)
                                                   .padding(.top, 12)
                                               }
                                               .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: HotelMapView()) {
                                                   HStack {
                                                       Image(systemName: "map.fill")
                                                       Text("View on Map")
                                                           .fontWeight(.semibold)
                                                   }
                                                   .frame(maxWidth: .infinity)
                                                   .padding()
                                                   .background(Color.blue)
                                                   .foregroundColor(.white)
                                                   .cornerRadius(12)
                                                   .padding(.top, 12)
                                               }
                                               .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
                .onAppear {
                    hotelVM.fetchHotels()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .preferredColorScheme(.dark)
}
