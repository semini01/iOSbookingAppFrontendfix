//
//  NotificationManager.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-21.
//


import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                print(granted ? " Notifications allowed" : " Notifications denied")
            }
        }

    func sendBookingNotification(for booking: Booking) {
        let content = UNMutableNotificationContent()
        content.title = "Booking Confirmed "
        
        let hotelName = booking.hotelName ?? "your hotel"
            let location = booking.location ?? "the selected city"

        content.body = "Your stay at \(hotelName) in \(location) is confirmed!"
            content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: booking.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error.localizedDescription)")
            } else {
                print("Booking notification scheduled")
            }
        }
    }
    
    func sendTourNotification(tour: String, guide: String, time: String) {
            let content = UNMutableNotificationContent()
            content.title = "Tour Confirmed "
            content.body = "\(tour) with \(guide) at \(time)"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    
    //to show banner while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .list])
    }
}
