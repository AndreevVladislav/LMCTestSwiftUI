//
//  M_MovieInfo.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation

// MARK: - модель информации о фильме
struct M_MovieInfo: Decodable {
    let kinopoiskId: Int
    
    /// Название
    let nameOriginal: String?
    
    /// Картинка
    let coverUrl: String?
    
    /// Рейтинг Кинопоиск
    let ratingKinopoisk: Double?
    
    let webUrl: String?
    /// Год фильма
    let year: Int?
    /// Описание фильма
    let description: String?
    /// Страны
    let countries: [Country]
    /// Жанры
    let genres: [Genre]
    /// Год премьеры
    let startYear: Int?
    /// Год последнего сезона
    let endYear: Int?
}
