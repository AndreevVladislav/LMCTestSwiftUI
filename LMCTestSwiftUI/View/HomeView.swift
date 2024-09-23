//
//  HomeView.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 22.09.2024.
//

import Foundation
import SwiftUI

//MARK: Главный экран
struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var apiUtils = APIUtils()
    
    @State private var searchString = ""
    
    /// Массив годов для выпадающего списка
    private let years = Array(1900...2024).reversed()
    
    /// Выбранный год (по умолчанию 2024)
    @State private var selectedYear: Int? = nil
    
    /// Список фильмов
    @State private var list_movies: [M_Movie] = [];
    
    @State private var isExpanded = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Constants.Colors.color_background
                    .ignoresSafeArea()
                VStack {
                    //MARK: Шапка
                    HStack {
                        ZStack {
                            //MARK: Тайтл
                            Text("KinoPoisk")
                                .foregroundColor(Constants.Colors.color_neonBlue)
                                .font(Font.system(size: 26, weight: .regular))
                            
                            HStack {
                                Spacer()
                                //MARK: Кнока выхода
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .foregroundColor(Constants.Colors.color_neonBlue)
                                }
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    HStack {
                        //MARK: Копка сортировка
                        Button(action: {
                            print("Кнопка нажата")
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(Constants.Colors.color_neonBlue)
                        }
                        .padding(.trailing, 5)
                        
                        //MARK: Строка поиска
                        TextField("Что осмотрим сегодня?", text: $searchString)
                            .padding()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                            .background(Constants.Colors.color_background)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay(
                                HStack {
                                    Spacer()
                                    
                                    //MARK: Кнопка поиска
                                    Button(action: {
                                        print("Search button tapped")
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                            .padding(.trailing, 16)
                                            .foregroundColor(Constants.Colors.color_neonBlue)
                                    }
                                }
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top)
                    
                    //MARK: Кнопка выбора года
                    Button(action: {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                    }) {
                        HStack {
                            Spacer()
                            if self.selectedYear != nil {
                                Text("\(selectedYear ?? 0)")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 15)
                            } else {
                                Text("Выбрать год")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 15)
                            }
                            
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .foregroundColor(Constants.Colors.color_neonBlue)
                            Spacer()
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                    
                    //MARK: Выпадающий список
                    if isExpanded {
                        ScrollView {
                            VStack(spacing: 0) {
                                Button(action: {
                                    self.selectedYear = nil
                                    withAnimation {
                                        self.isExpanded = false
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "xmark.circle")
                                        Text("Сбросить выбор")
                                    }
                                    .foregroundColor(.red)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                }
                                Divider()

                                ForEach(years, id: \.self) { year in
                                    Button(action: {
                                        self.selectedYear = year
                                        withAnimation {
                                            self.isExpanded = false
                                        }
                                    }) {
                                        Text("\(year)")
                                            .foregroundColor(self.selectedYear == year ? .white : .blue)
                                            .padding(.vertical, 10)
                                            .frame(maxWidth: .infinity)
                                            .background(self.selectedYear == year ? Color.blue : Color.clear)
                                    }
                                }
                                
                            }
                        }
                        .frame(maxHeight: 250) // Ограничение высоты списка
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(.horizontal, 16)
                    }
                    
                    //MARK: таблица с фильмами
                    ZStack {
                        Constants.Colors.color_background
                        ScrollView {
                            VStack {
                                ForEach(self.list_movies) { movie in
                                    NavigationLink(destination: MovieInfoView(movieId: movie.kinopoiskId)) {
                                        UC_MovieItem(movieItem: movie)

                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            self.list_movies = [M_Movie(kinopoiskId: 123,
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
                                        posterUrlPreview: ""),
                                M_Movie(kinopoiskId: 111,
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
                                        posterUrlPreview: ""),
                                M_Movie(kinopoiskId: 222,
                                        imdbId: "imdbId",
                                        nameRu: "nameRu",
                                        nameEn: "nameEn",
                                        nameOriginal: "nameOriginal",
                                        countries: [Country(country: "Россия")],
                                        genres: [Genre(genre: "комедия"), Genre(genre: "комедия"), Genre(genre: "комедия")],
                                        ratingKinopoisk: 9.5,
                                        ratingImdb: 9.5,
                                        year: 2024,
                                        type: "FILM",
                                        posterUrl: "",
                                        posterUrlPreview: "")
            ]
        
        }
    }
}

#Preview {
    HomeView()
}
