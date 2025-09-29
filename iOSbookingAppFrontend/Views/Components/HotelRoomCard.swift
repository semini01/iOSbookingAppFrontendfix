//
//  HotelRoomCard.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-19.
//

import SwiftUI

struct RoomTypeCard: View {
    var room: RoomType
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
          
            Text(room.type)
                .font(.headline)
                .foregroundColor(.primary)
            
           
            Text("Capacity: \(room.capacity) people")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
          
            Text("$\(room.price, specifier: "%.2f") / night")
                .font(.subheadline)
                .foregroundColor(.orange)
            
           
            VStack(alignment: .leading, spacing: 4) {
                ForEach(room.facilities.prefix(3), id: \.self) { facility in
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text(facility)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .frame(width: 200)
        .background(isSelected ? Color.blue.opacity(0.15) : Color(.systemBackground)) 
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    RoomTypeCard(
        room: RoomType(
            id: "1",
            hotelId: "101",
            type: "Deluxe Room",
            price: 150,
            capacity: 2,
            facilities: ["WiFi", "Air Conditioning", "Pool Access"],
            createdAt: nil,
            updatedAt: nil,
            v: nil
        ),
        isSelected: true
    )
}
