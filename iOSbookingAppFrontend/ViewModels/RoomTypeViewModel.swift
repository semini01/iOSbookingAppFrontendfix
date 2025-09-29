//
//  RoomTypeViewModel.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-27.
import Foundation

class RoomTypeViewModel: ObservableObject {
    @Published var rooms: [RoomType] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchRooms(for hotelId: String) {
       
        guard let url = URL(string: "http://192.168.1.33:5000/roomtypes/hotel/\(hotelId)") else { return }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else { return }
            
            // Debug
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON:", jsonString)
            }
            
            do {
                let decoded = try JSONDecoder().decode([RoomType].self, from: data)
                DispatchQueue.main.async {
                    self.rooms = decoded
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
