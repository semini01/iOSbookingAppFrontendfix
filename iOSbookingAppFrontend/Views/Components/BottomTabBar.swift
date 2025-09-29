//
//  BottomTabBar.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-25.
//
import SwiftUI

struct BottomTabBar: View {
    @State private var selectedTab: Tab = .home
    //@StateObject var tabState = TabState()
        
    
    enum Tab {
        case home, bookings, tourGuidance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            
            TourGuideView()
                .tabItem {
                    Image(systemName: "person.fill.viewfinder")
                    Text("Tour Guidance")
                }
                .tag(Tab.tourGuidance)
            
            BookingHistoryView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Bookings")
                }
                .tag(Tab.bookings)
            
            
//            ProfileView()
//                .tabItem {
//                    Image(systemName: "person.crop.circle.fill")
//                    Text("Profile")
//                }
//                .tag(Tab.profile)
//            
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "gearshape.fill")
//                    Text("Settings")
//                }
//                .tag(Tab.settings)
        }
        .accentColor(.blue) // active tab color
    }
}


#Preview {
    BottomTabBar()
}
