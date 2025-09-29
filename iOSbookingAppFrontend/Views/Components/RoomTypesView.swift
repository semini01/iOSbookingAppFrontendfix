//
//  RoomTypesView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-27.
//

import SwiftUI

struct RoomTypesView: View {
    let hotelId: String
    @StateObject private var roomVM = RoomTypeViewModel()
    
    @Binding var selectedRoomId: String?
        @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if roomVM.isLoading {
                    ProgressView("Loading rooms...")
                        .foregroundColor(.white)
                } else if let error = roomVM.errorMessage {
                    Text("Warning \(error)")
                        .foregroundColor(.red)
                } else if roomVM.rooms.isEmpty {
                    Text("No rooms available.")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(roomVM.rooms) { room in
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            Text(room.type)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("$\(room.price, specifier: "%.2f")")
                                                .foregroundColor(.orange)
                                                .font(.subheadline.bold())
                                        }
                                        
                                        Text("Capacity: \(room.capacity) people")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        // Facilities
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(room.facilities, id: \.self) { facility in
                                                    Text(facility)
                                                        .font(.caption2)
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 4)
                                                        .background(Color.gray.opacity(0.4))
                                                        .cornerRadius(6)
                                                }
                                            }
                                        }
                                    }
                                    
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(
                                    selectedRoomId == room.id
                                    ? Color.blue.opacity(0.2) : Color.white.opacity(0.05))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                                .onTapGesture {
                                    withAnimation {
                                        selectedRoomId = room.id
                                        dismiss()
                                    }
                                }
                            }
                                        }
                                        .padding()
                            }
                }
            }
            .navigationTitle("Room Types")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            roomVM.fetchRooms(for: hotelId)
        }
    }
}


#Preview {
    RoomTypesView(hotelId: "1", selectedRoomId: .constant(nil))

}
