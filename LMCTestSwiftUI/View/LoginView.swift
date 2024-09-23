//
//  LoginView.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 21.09.2024.
//

import SwiftUI

//MARK: Окно авторизации/регистрации
struct LoginView: View {
    
    @StateObject private var loginUtils = LoginUtils()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var presentHomeView = false
    
    var body: some View {
        ZStack {
            Constants.Colors.color_background
                .ignoresSafeArea()
            VStack(spacing: 130) {
                /// Тайтл
                Text("KinoPoisk")
                    .foregroundColor(Constants.Colors.color_neonBlue)
                    .font(Font.system(size: 70, weight: .regular))
                VStack(spacing: 20) {
                    /// Поле для ввода логина
                    TextField("Логин", text: $loginUtils.username)
                        .padding()
                        .background(Constants.Colors.color_background)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                    
                    /// Поле для ввода пароля
                    SecureField("Пароль", text: $loginUtils.password)
                        .padding()
                        .background(Constants.Colors.color_background)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                
                }
                .padding(.horizontal, 20)
                
                /// Кнопка "Войти"
                VStack {
                    Button(action: {
                        self.loginUtils.login()
                    }) {
                        Text("Войти")
                            .font(Font.system(size: 20, weight: .regular))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Constants.Colors.color_neonBlue)
                            .cornerRadius(8)
                    }
                    /// Кнопка удаления всех зарегестрированных пользователей
//                    Button("Очистить всех пользователей") {
//                        KeychainHelper.clearAll()
//                        print("Все пользователи удалены")
//                    }
//                    .padding()
//                    .foregroundColor(.black)
                }
                .padding(.horizontal, 20)
                
                
            }
        }
        .fullScreenCover(isPresented: $loginUtils.flag_validAuth) {
            HomeView()
        }
        .alert(isPresented: $loginUtils.showAlert) {
            Alert(title: Text("Ошибка"), message: Text(loginUtils.alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }
        
        
    }
}

#Preview {
    LoginView()
}
