//
//  Hotel.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-03.
//

import Foundation
import CoreLocation

struct Hotel: Identifiable, Codable {
    let id: String
    let name: String
    let city: String?
    let rating: Double?
    let price: Double?
    let imageUrl: String?
    let latitude: Double
    let longitude: Double
    let facilities: [String]?
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"   //  map MongoDB’s _id to Swift’s id
        case name, city, rating, price, imageUrl, latitude, longitude, facilities
    }
    
    
}

