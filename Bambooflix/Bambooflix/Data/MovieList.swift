//
//  MoviesList.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 07/04/2021.
//

import Foundation


struct MovieList: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
