//
//  DetailVC.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 12/04/2021.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class DetailVC: UIViewController {
    
    let moviesManager = MoviesManager()
   
    
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    @IBOutlet var budgetLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var productionLabel: UILabel!
    
    let movieID = MoviesViewModel.selectedMovieId
    
    func buildBudget(movie: Int) -> String {
        let budget = movie / 1000000
        return String("\(budget).0M$")
    }
    
    func buildGenreDescription(movie: [Genre]) -> String {
        let stringGenre = movie.map{$0.name}
        let newList = stringGenre.joined(separator: ", ")
       
        return "Géneros: \(newList)"
    }
    
    func builProductionCompaniesDescription(movie: [ProductionCompany]) -> String {
        let stringProduction = movie.map{$0.name}
        let newList = stringProduction.joined(separator: ", ")
        return "Producida por: \(newList)"
    }
    
    func configureDetails() {
        guard let movieID = movieID else { return }
        moviesManager.fetchMovieDetails(movieId: movieID) { (movie) in
            let popularity = Int(movie.popularity)
            self.movieTitle.text = movie.originalTitle
            self.popularityLabel.text = "Popularidad: \(popularity)"
            self.releaseDateLabel.text = movie.releaseDate
            self.voteAverageLabel.text = "\(movie.voteAverage)"
            self.budgetLabel.text = self.buildBudget(movie: movie.budget)
            self.overviewLabel.text = movie.overview
            self.genreLabel.text = self.buildGenreDescription(movie: movie.genres)
            self.productionLabel.text = self.builProductionCompaniesDescription(movie: movie.productionCompanies)
                
            
        }
        
    }
    
    override func viewDidLoad() {
        configureDetails()
 
    }

}
