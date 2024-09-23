//
//  GenericResponse.swift
//  LMCTestSwiftUI
//
//  Created by Vladislav Andreev on 23.09.2024.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    let total: Int
    let totalPages: Int
    let items: [T]
}
