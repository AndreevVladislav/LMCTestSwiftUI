//
//  M_Movie.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 22.09.2024.
//

import Foundation
import UIKit

// MARK: структура для парсинга фильмов в таблицах
public struct M_Movie: Identifiable, Codable {
    
    public var id: UUID = UUID();
    
    /// ID фильма
    public let kinopoiskId: Int
    public let imdbId: String?
    
    /// Название на русском
    public let nameRu: String?
    
    /// Название на английском
    public let nameEn: String?
    
    /// Оригинальное название
    public let nameOriginal: String?
    
    /// Страны
    public let countries: [Country]
    
    /// Жанры
    public let genres: [Genre]
    
    /// Рейтинг кинопоиска
    public let ratingKinopoisk: Double?
    public let ratingImdb: Double?
    
    /// Год выпуска
    public let year: Int
    
    /// Тип ( FILM, VIDEO, TV_SERIES, MINI_SERIES, TV_SHOW )
    public let type: String
    
    ///Картинка фильма
    public let posterUrl: String
    public let posterUrlPreview: String
}

// MARK: - Country
public struct Country: Identifiable, Codable {
    
    public var id: UUID = UUID();
    
    public let country: String
}

// MARK: - Genre
public struct Genre: Identifiable, Codable{
    
    public var id: UUID = UUID();
    
    public let genre: String
}
