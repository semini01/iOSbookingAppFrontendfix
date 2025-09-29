//
//  RoomType.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-19.
//

struct RoomType: Codable, Identifiable {
    let id: String
    let hotelId: String
    let type: String
    let price: Double
    let capacity: Int
    let facilities: [String]
    let createdAt: String?
    let updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hotelId, type, price, capacity, facilities
        case createdAt, updatedAt
        case v = "__v"
    }
}
