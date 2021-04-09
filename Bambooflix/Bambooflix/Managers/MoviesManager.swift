//
//  MoviesManager.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 09/04/2021.
//

import Foundation
import Alamofire
import AlamofireImage


struct MoviesManager {
    
let apiKeyValue: String = "d3e5f2e7aa48d158fe52cb91d420410c"
    
    func fetchMovieDiscover(success: @escaping (MovieList) -> ()) {
        let url = Endpoints.moviesList.url
        let parameters: [String:String] = [EndpointParameter.apiKey.rawValue : apiKeyValue]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: MovieList.self) { (response) in
            
            guard let movieList: MovieList = response.value  else  { return }
            success(movieList)
            // Aquí cridariem a success
            
        }
    }
    
    func fetchMovieDetails(movieId: Int, success: @escaping (MovieDetail) -> ()) {
        let url = Endpoints.movieDetail.url + String(movieId)
        let parameters: [String:String] = [EndpointParameter.apiKey.rawValue : apiKeyValue]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: MovieDetail.self) { (response) in
            
            guard let movieDetail: MovieDetail = response.value  else  { return }
            success(movieDetail)
            
        }
    }
    
}
