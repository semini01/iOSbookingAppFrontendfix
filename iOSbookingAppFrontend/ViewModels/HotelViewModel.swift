//
//  HotelViewModel.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-26.
//

import Foundation

class HotelViewModel: ObservableObject {
    @Published var hotels: [Hotel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchHotels() {
        guard let url = URL(string: "http://192.168.1.33:5000/hotels") else { return }
        

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
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async { self.errorMessage = "Invalid server response" }
                return
            }

            guard let data = data else { return }

            do {
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(" Raw JSON from backend:\n", jsonString)
                }

               
                let hotels = try JSONDecoder().decode([Hotel].self, from: data)
                DispatchQueue.main.async {
                    self.hotels = hotels
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }

        }.resume()
    }
}

