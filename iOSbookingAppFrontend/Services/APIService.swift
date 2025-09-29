//
//  APIService.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-06.
//
import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "http://192.168.1.33:5000/auth"

    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                            let response = try JSONDecoder().decode(AuthResponse.self, from: data)
                            completion(.success(response.token))
                        } catch {
                            
                            if let jsonString = String(data: data, encoding: .utf8) {
                                print("Login decode failed. Raw response:", jsonString)
                            }
                            completion(.failure(error))
                        }
            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                   let token = json["token"] as? String {
//                    completion(.success(token))
//                } else {
//                    throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
//                }
//            } catch {
//                completion(.failure(error))
//            }
        }.resume()
    }
    
    func signup(name: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/signup") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            
                       do {
                           let response = try JSONDecoder().decode(AuthResponse.self, from: data)
                           completion(.success(response.token))
                       } catch {
                           // 🔹 Debug: print raw backend response
                           if let jsonString = String(data: data, encoding: .utf8) {
                               print(" Signup decode failed. Raw response:", jsonString)
                           }
                           completion(.failure(error))
                       }
          
        }.resume()
    }
    
    func fetchHotels(completion: @escaping (Result<[Hotel], Error>) -> Void) {
            guard let url = URL(string: "\(baseURL)/hotels") else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let hotels = try JSONDecoder().decode([Hotel].self, from: data)
                    completion(.success(hotels))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }

}
