//
//  APIUtils.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class APIUtils: ObservableObject {
    
    @Published var movies: [M_Movie] = []
    @Published var flag_moviePolucheni = false
    
    // Функция для получения популярных фильмов
    func fetchPopularMovies() {
        let apiKey = "de1db718-950e-449d-88a1-39a41062cee6"  // Замените на ваш реальный API ключ
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/collections?type=TOP_POPULAR_MOVIES&page=1"
        
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        // Создание сессии и задачи для выполнения запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Нет данных в ответе")
                return
            }
            
            do {
                // Декодируем JSON-ответ
                let movieResponse = try JSONDecoder().decode(GenericResponse<M_Movie>.self, from: data)
                // Выводим полученные данные в консоль
                print("Общее количество фильмов: \(movieResponse.total)")
                for movie in movieResponse.items {
                    print("Фильм: \(movie.nameRu), Год: \(movie.year), Рейтинг: \(movie.ratingKinopoisk)")
                    self.flag_moviePolucheni = true
                }
            } catch {
                print("Ошибка декодирования JSON: \(error)")
            }
        }
        
        task.resume()  // Запускаем задачу
    }
    
}



