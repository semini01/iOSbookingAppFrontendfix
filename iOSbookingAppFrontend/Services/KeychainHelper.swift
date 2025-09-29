import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    func saveToken(_ token: String) {
        let key = "authToken"
        if let data = token.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            
            SecItemDelete(query) // delete old
            SecItemAdd(query, nil)
        }
    }
    
    func getToken() -> String? {
        let key = "authToken"
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
