//
//  MovieInfoView.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation
import SwiftUI

//MARK: Окно информации о фильме
struct MovieInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var movieId = Int()
    
    @State private var movie = M_MovieInfo(kinopoiskId: 123, 
                                           nameOriginal: "nameOriginal",
                                           coverUrl: "coverUrl",
                                           ratingKinopoisk: 9.5,
                                           webUrl: "webUrl", year: 2024,
                                           description: "Мы любим животных и стараемся поддерживать тех из них, кому не посчастливилось иметь ласковых хозяев и тёплый кров. Один из проверенных способов это сделать — помочь благотворительному фонду «Луч Добра». Благодаря их труду ежегодно сотни питомцев находят свой новый дом.",
                                           countries: [Country(country: "Россия"),
                                                       Country(country: "Россия"),
                                                       Country(country: "Россия")] ,
                                           genres: [Genre(genre: "Комедия") ,
                                                    Genre(genre: "Комедия") ,
                                                    Genre(genre: "Комедия")],
                                           startYear: 2024,
                                           endYear: 2024)
    
    @State private var framesArray = [Frame(image: Constants.Images.img_zaglushka),
                                      Frame(image: Constants.Images.img_zaglushka),
                                      Frame(image: Constants.Images.img_zaglushka),
                                      Frame(image: Constants.Images.img_zaglushka),
                                      Frame(image: Constants.Images.img_zaglushka)]
    
    var body: some View {
        ZStack {
            Constants.Colors.color_background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    ZStack {
                        GeometryReader { geometry in
                            //MARK: Картинка
                            Constants.Images.img_zaglushka
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 450)
                                .clipped()
                        }
                        .frame(height: 450)
                        VStack {
                            HStack {
                                //MARK: Копка "Назад"
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .padding(.top, 50)
                            Spacer()
                            HStack {
                                //MARK: Название фильма
                                Text("\(self.movie.nameOriginal ?? "")")
                                    .font(Font.system(size: 26, weight: .bold))
                                    .padding()
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(String(format: "%.1f", self.movie.ratingKinopoisk ?? 0))")
                                    .font(Font.system(size: 26, weight: .bold))
                                    .padding()
                                    .foregroundColor(Constants.Colors.color_neonBlue)
                            }
                        }
                    }
                    HStack {
                        Text("Описание")
                            .font(Font.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        //MARK: кнопка перехода в браузер
                        Link(
                            destination: URL(string: "https://www.kinopoisk.ru")!){
                                Image(systemName: "link")
                                    .foregroundColor(Constants.Colors.color_neonBlue)
                            }
                        
                    }
                    .padding(.horizontal)
                    
                    //MARK: Описание фильма
                    Text("\(self.movie.description ?? "")")
                        .font(Font.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    //MARK: Жанры
                    let genreNames = self.movie.genres.map { $0.genre }.joined(separator: ", ")
                    
                    HStack {
                        Text(genreNames)
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .lineLimit(0)
                        Spacer()
                    }
                    
                    let countryNames = self.movie.countries.map { $0.country }.joined(separator: ", ")
                    
                    HStack {
                        //MARK: Год
                        Text("\(self.movie.year ?? 0),")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .lineLimit(0)
                        //MARK: Страны
                        Text(countryNames)
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                            .lineLimit(0)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Кадры")
                            .font(Font.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    //MARK: Кадры
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.framesArray) { frame in
                                frame.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 160, height: 120)
                                    .clipped()
                                    .padding(.leading)
                                    .padding(.vertical)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
//            print(movieId)
        }
    }
}

#Preview {
    MovieInfoView()
}
