//
//  LoginUtils.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation
import SwiftUI
import Combine

class LoginUtils: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String?
    @Published var showAlert: Bool = false
    @Published var flag_validAuth: Bool = false
    
    func login() {
        if username == "" || password == "" {
            alertMessage = "Введите логин и пароль"
            showAlert = true
            flag_validAuth = false
        } else {
            if let savedPassword = KeychainHelper.load(key: username) {
                if savedPassword == password {
                    // Успешный вход
                    flag_validAuth = true
                } else {
                    // Неверный пароль
                    alertMessage = "Неверный пароль"
                    showAlert = true
                    flag_validAuth = false
                }
            } else {
                // Регистрируем нового пользователя
                KeychainHelper.save(key: username, data: password)
                flag_validAuth = true
            }
        }
    }
}
