////
////  AuthViewModel.swift
////  iOSbookingAppFrontend
////
////  Created by Semini Wickramasinghe on 2025-09-07.
//


//import Foundation
//import LocalAuthentication
//
//class AuthViewModel: ObservableObject {
//    @Published var isLoggedIn = false
//
//    // MARK: - Login
//    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
//        APIService.shared.login(email: email, password: password) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let authResponse):
//                    print("✅ Logged in, token: \(authResponse.token)")
//                    KeychainHelper.standard.save(authResponse.token, service: "auth", account: "userToken")
//                    
//                    self.isLoggedIn = true
//                    completion(true)
//                case .failure(let error):
//                    print("❌ Login failed:", error.localizedDescription)
//                    completion(false)
//                }
//            }
//        }
//    }
//
//    // MARK: - Check token
//    func hasToken() -> Bool {
//        return KeychainHelper.standard.read(service: "auth", account: "userToken") != nil
//    }
//
//    // MARK: - Face ID
//    func authenticateWithFaceID(completion: @escaping (Bool) -> Void) {
//        guard hasToken() else {
//            print("❌ No token stored, login first")
//            completion(false)
//            return
//        }
//
//        let context = LAContext()
//        var evalError: NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &evalError) {
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
//                                   localizedReason: "Login with Face ID") { success, _ in
//                DispatchQueue.main.async {
//                    if success {
//                        self.isLoggedIn = true
//                        completion(true)
//                    } else {
//                        completion(false)
//                    }
//                }
//            }
//        } else {
//            print("❌ Face ID not available:", evalError?.localizedDescription ?? "")
//            completion(false)
//        }
//    }
//}

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String? = nil
    
    func login(email: String, password: String) {
        guard let url = URL(string: "http://localhost:5000/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No response from server"
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if json?["token"] != nil {
                       
                        self.isLoggedIn = true
                    } else {
                        self.errorMessage = "Invalid credentials"
                    }
                } catch {
                    self.errorMessage = "Failed to parse response"
                }
            }
        }.resume()
    }
    
    func signup(name: String, email: String, password: String) {
        guard let url = URL(string: "http://localhost:5000/auth/signup") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["name": name, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No response from server"
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let msg = json?["msg"] as? String {
                        print("Signup success:", msg)
                    } else {
                        self.errorMessage = "Signup failed"
                    }
                } catch {
                    self.errorMessage = "Failed to parse response"
                }
            }
        }.resume()
    }
    
    func logout() {
        isLoggedIn = false
    }
}
