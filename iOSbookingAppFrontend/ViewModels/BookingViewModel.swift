//
//  BookingViewModel.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-18.
//


import Foundation

class BookingViewModel: ObservableObject {
    @Published var booking: Booking?
    @Published var errorMessage: String?
    
    func createBooking(_ bookingData: [String: Any], completion: @escaping (Booking?) -> Void) {
        guard let url = URL(string: "http://192.168.1.33:5000/bookings") else { DispatchQueue.main.async {
            self.errorMessage = "Invalid URL"
            completion(nil)
        }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: bookingData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
               
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedResponse = try decoder.decode(Booking.self, from: data)
                
                DispatchQueue.main.async {
                                    self.booking = decodedResponse
                                    completion(decodedResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                    completion(nil)
                }
            }
        }.resume()
    }
}
