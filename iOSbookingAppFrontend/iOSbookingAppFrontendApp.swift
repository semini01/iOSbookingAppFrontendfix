//
//  iOSbookingAppFrontendApp.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-06.
//


import SwiftUI
import UserNotifications


@main
struct iOSbookingAppFrontendApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
        @AppStorage("didSeeWelcome") private var didSeeWelcome: Bool = false
        
    
    init() {
        let center = UNUserNotificationCenter.current()
        
        
        center.delegate = NotificationManager.shared
        
       
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(" Notification permission error: \(error.localizedDescription)")
            } else if granted {
                print(" Notifications allowed")
            } else {
                print(" Notifications denied")
            }
        }
    }

    
    
//    
//    var body: some Scene {
//        WindowGroup {
//          //  //ContentView()
//        WelcomeView()
//         // LoginView()
//           // SignUpView()
//          //DashboardView()
//   //       //  SignInView()
//          //  HotelCardView()
//            //TourGuideView()
//            //HotelDetailView(hotel: .sample)
//         //   BookingHistoryView()
//
//                }
//        }
//    }
//
    var body: some Scene {
            WindowGroup {
                if !didSeeWelcome {
                    WelcomeView()
                } else if !isLoggedIn {
                    LoginView()
                } else {
                    BottomTabBar()
                }
            }
        }
    }
