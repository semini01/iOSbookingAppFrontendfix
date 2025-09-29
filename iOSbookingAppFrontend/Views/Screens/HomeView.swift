//
//  HomeView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-25.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Black background
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // App Title
                    Text("EliteStay Hotels")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 6)
                        .padding(.top, 40)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Hotels, Cities...", text: .constant(""))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Featured Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Featured Hotels")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 16) {
//                                ForEach(0..<5) { index in
//                                    NavigationLink {
//                                        HotelDetailView()
//                                    } label: {
//                                        HotelCardView(imageName: "hotel\(index % 3 + 1)", title: "Hotel \(index + 1)", location: "City \(index + 1)")
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Bottom Navigation Buttons
                    HStack(spacing: 30) {
                        BottomNavButton(icon: "house.fill", title: "Home")
                        BottomNavButton(icon: "map.fill", title: "Explore")
                        BottomNavButton(icon: "heart.fill", title: "Favorites")
                        BottomNavButton(icon: "person.fill", title: "Profile")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
        }
    }
}

// Hotel Card View
//struct HotelCardView: View {
//    var imageName: String
//    var title: String
//    var location: String
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            Image(imageName)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 180, height: 120)
//                .cornerRadius(15)
//                .clipped()
//            
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(location)
//                .font(.subheadline)
//                .foregroundColor(.white.opacity(0.7))
//        }
//        .frame(width: 180)
//        .background(Color.white.opacity(0.1))
//        .cornerRadius(15)
//        .shadow(radius: 5)
//    }
//}

// Hotel Detail View (Placeholder)
//struct HotelDetailView: View {
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            Text("Hotel Details Page")
//                .font(.title)
//                .foregroundColor(.white)
//        }
//    }
//}

// Bottom Navigation Button
struct BottomNavButton: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    HomeView()
}
