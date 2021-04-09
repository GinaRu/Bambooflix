//
//  moviesViewCell.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 07/04/2021.
//

import UIKit

class MoviesViewCell: UITableViewCell {
    
    
    @IBOutlet var boto1: UIButton!
    @IBOutlet var boto2: UIButton!
    @IBOutlet var boto3: UIButton!
    @IBOutlet var boto4: UIButton!
    @IBOutlet var boto5: UIButton!
    @IBOutlet var boto6: UIButton!
    
    
    func configure(with movies: MovieList) {
        for movie in movies.results {
            if let url = URL(string: Endpoints.movieImage.rawValue + movie.posterPath) {
                boto1.af.setImage(for: .normal, url: url)
            }
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
