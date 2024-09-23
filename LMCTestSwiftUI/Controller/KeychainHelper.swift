//
//  KeychainHelper.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation
import Security

class KeychainHelper {
    static func save(key: String, data: String) {
        if let data = data.data(using: .utf8) {
            let query = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ] as [String: Any]
            
            SecItemDelete(query as CFDictionary) // Удаляем старые данные
            SecItemAdd(query as CFDictionary, nil)
        }
    }

    static func load(key: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    static func clearAll() {
        let query = [
            kSecClass as String: kSecClassGenericPassword
        ] as [String: Any]
        
        // Удаляем все записи с указанным классом
        SecItemDelete(query as CFDictionary)
    }
}
