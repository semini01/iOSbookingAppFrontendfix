//
//  Booking.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


//struct Booking: Codable, Identifiable {
//    let id: String
//    let hotelName: String
//    let location: String
//    let checkInDate: Date
//    let checkOutDate: Date
//}

import Foundation

struct Booking: Codable, Identifiable {
    let id: String
    let hotelId: String
    let roomId: String
    let checkInDate: Date
    let checkOutDate: Date
    
    
    let hotelName: String?
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hotelId
        case roomId
        case checkInDate
        case checkOutDate
        case hotelName
        case location
    }
}
