//
//  UC_MovieItem.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 22.09.2024.
//

import Foundation
import SwiftUI

struct UC_MovieItem: View {
    
    @State public var movieItem: M_Movie;
    
    var body: some View {
        ZStack {
            Constants.Colors.color_background
                .ignoresSafeArea()
            HStack {
                ///Картинка
                Constants.Images.img_zaglushka
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140)
                    .clipped()
                    .cornerRadius(10)
                
                VStack(spacing: 10) {
                    HStack {
                        /// Название фильма
                        Text("\(self.movieItem.nameOriginal ?? "Название не указано")")
                            .foregroundColor(.white)
                            .font(Font.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        /// Жанры фильма
                        Text(self.movieItem.genres.map { $0.genre }.joined(separator: ", "))
                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        ///Год фильма
                        Text("\(self.movieItem.year),")
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundColor(.gray)
                        /// Страны фильма
                        Text(self.movieItem.countries.map { $0.country }.joined(separator: ", "))
                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        /// Рейтинг
                        Text(String(format: "%.1f", self.movieItem.ratingKinopoisk ?? 0))
                            .font(Font.system(size: 26, weight: .bold))
                            .foregroundColor(Constants.Colors.color_neonBlue)
                    }
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    UC_MovieItem(movieItem: M_Movie(kinopoiskId: 123,
                                    imdbId: "imdbId",
                                    nameRu: "nameRu",
                                    nameEn: "nameEn",
                                    nameOriginal: "nameOriginal",
                                    countries: [Country(country: "Россия"), Country(country: "Россия"), Country(country: "Россия")],
                                    genres: [Genre(genre: "комедия"), Genre(genre: "комедия"), Genre(genre: "комедия")],
                                    ratingKinopoisk: 9.5,
                                    ratingImdb: 9.5,
                                    year: 2024,
                                    type: "FILM",
                                    posterUrl: "",
                                    posterUrlPreview: ""))
}
