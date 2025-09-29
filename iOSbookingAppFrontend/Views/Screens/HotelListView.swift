////
////  HotelListView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-14.
////
//import SwiftUI
//
//struct HotelListView: View {
//    let hotels: [Hotel]  
//
//    var body: some View {
//        List(hotels) { hotel in
//            NavigationLink(destination: HotelDetailView(hotel: hotel)) {
//                VStack(alignment: .leading) {
//                    Text(hotel.name)
//                        .font(.headline)
//                    Text("\(hotel.city) •  \(hotel.rating, specifier: "%.1f")")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
//        .navigationTitle("Search Results")
//    }
//}
//
//#Preview {
//    HotelListView(hotels: [])
//}
