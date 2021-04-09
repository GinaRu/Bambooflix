//
//  Endpoints.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 09/04/2021.
//

import Foundation


enum Endpoints: String {

    case moviesList = "https://api.themoviedb.org/3/discover/movie"
    case movieDetail = "https://api.themoviedb.org/3/movie/"
    case movieImage = "https://image.tmdb.org/t/p/w500"

    var url: String {
        return self.rawValue
    }

}

enum EndpointParameter: String {
    case apiKey = "api_key"
}
