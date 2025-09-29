//
//  BiometricAuth.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//

import Foundation
import LocalAuthentication

struct BiometricAuth {
    static func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Log in with Face ID") { success, authError in
                DispatchQueue.main.async {
                    completion(success && authError == nil)
                }
            }
        } else {
            completion(false)
        }
    }
}
