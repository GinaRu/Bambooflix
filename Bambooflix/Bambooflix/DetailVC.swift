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
import AVFoundation
import AVKit

class DetailVC: UIViewController {
    
    let moviesManager = MoviesManager()
    let movieID = MoviesViewModel.selectedMovieId
    
    func configureElements(_ movie: MovieDetail) {
        let popularity = Int(movie.popularity)
        self.movieTitle.text = movie.originalTitle
        self.popularityLabel.text = "Popularidad: \(popularity)"
        self.releaseDateLabel.text = movie.releaseDate
        self.voteAverageLabel.text = "\(movie.voteAverage)"
        self.budgetLabel.text = self.buildBudget(movie: movie.budget)
        self.overviewLabel.text = movie.overview
        self.genreLabel.text = self.buildGenreDescription(movie: movie.genres)
        self.productionLabel.text = self.buildProductionCompaniesDescription(movie: movie.productionCompanies)
        
        if let videoURL = movie.videoURL {
           configurePlayer(videoURL: videoURL)
        } else {
            debugPrint("Error: video URL invalid in \(#function)")
        }
    }
    func configureDetails() {
        guard let movieID = movieID else { return }
        moviesManager.fetchMovieDetails(movieId: movieID) { (movie) in
            self.configureElements(movie)
        }
    }
    func buildBudget(movie: Int) -> String {
        let budget = movie / 1000000
        return String("\(budget).0M$")
    }
    func buildGenreDescription(movie: [Genre]) -> String {
        let stringGenre = movie.map{$0.name}
        let newList = stringGenre.joined(separator: ", ")
       
        return "Géneros: \(newList)"
    }
    func buildProductionCompaniesDescription(movie: [ProductionCompany]) -> String {
        let stringProduction = movie.map{$0.name}
        let newList = stringProduction.joined(separator: ", ")
        return "Producida por: \(newList)"
    }
    private func configurePlayer(videoURL: URL) {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        guard let playerView = playerViewController.view else { debugPrint("Error: Player is nil")
            return }
        
        self.addChild(playerViewController)
        videoView.addSubview(playerView)
        playerViewController.didMove(toParent: self)
       
        playerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: playerView, attribute: .top, relatedBy: .equal, toItem: videoView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: playerView, attribute: .bottom, relatedBy: .equal, toItem: videoView, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: playerView, attribute: .leading, relatedBy: .equal, toItem: videoView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: playerView, attribute: .trailing, relatedBy: .equal, toItem: videoView, attribute: .trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        
        player.play()
    }
    
    func shareMovieRecomendation(){
        guard let titleUnwraped = movieTitle.text else {return}
          let titleText = "No te puedes perder \(titleUnwraped). ¡Puedes verla en la app Bambooflix!"
             let vc = UIActivityViewController(activityItems: [titleText], applicationActivities: [])
             present(vc, animated: true)
    }
    
 
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    @IBOutlet var budgetLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var productionLabel: UILabel!
    @IBOutlet var videoView: UIView!
    
    @IBAction func shareButton(_ sender: UIButton) {
     shareMovieRecomendation()
    }
    
    override func viewDidLoad() {
        configureDetails()
    }
    

}


