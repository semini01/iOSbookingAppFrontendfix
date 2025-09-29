//
//  Tour.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-28.
//


import Foundation

struct Tour: Identifiable {
    let id = UUID()
    let title: String
    let price: Double
    let timeSlots: [String]
}

struct Guide: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let image: String
    let tours: [Tour]
}
