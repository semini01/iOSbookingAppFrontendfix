//
//  User.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-06.
//

import Foundation

struct AuthResponse: Codable {
    let message: String?
    let token: String
    let user: User
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
    
//    enum CodingKeys: String, CodingKey {
//           case id = "_id"
//           case name
//           case email
//       }
}
