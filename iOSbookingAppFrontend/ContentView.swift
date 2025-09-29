////
////  ContentView.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-06.
////
//
////import SwiftUI
////
////struct ContentView: View {
////    
////    @EnvironmentObject var authViewModel: AuthViewModel
////
////        var body: some View {
////            if authViewModel.isLoggedIn {
////                DashboardView()
////            } else {
////                WelcomeView()
////            }
////        }
//////    @State private var selectedTab = 0
//////    
//////    var body: some View {
//////        VStack(spacing: 0) {
////////            
////////            // Page content
////////            Group {
////////                switch selectedTab {
////////                case 0: DashboardView()
//////////                case 1: SearchView()
//////////                case 2: BookingsView()
//////////                case 3: ProfileView()
////////                default: DashboardView()
////////                }
////////            }
////////            .frame(maxWidth: .infinity, maxHeight: .infinity)
////////            
////////            
//////        }
//////    }
////}
////
////#Preview {
////    ContentView()
////}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var isLoggedIn = false
//    
//    var body: some View {
//        if isLoggedIn {
//            DashboardView()
//        } else {
//            LoginView(isLoggedIn: $isLoggedIn)
//        }
//    }
//}
//
//
//
//#Preview {
//    ContentView()
//}
