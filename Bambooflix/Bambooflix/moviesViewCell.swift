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
    
    
    func configure(with movies: [Movie]) {
        setImageAt(movie: movies[0], button: boto1)
        setImageAt(movie: movies[1], button: boto2)
        setImageAt(movie: movies[2], button: boto3)
        setImageAt(movie: movies[3], button: boto4)
        setImageAt(movie: movies[4], button: boto5)
        setImageAt(movie: movies[5], button: boto6)
    
    }
    
    func setImageAt(movie: Movie, button: UIButton) {
        if let url = URL(string: Endpoints.movieImage.rawValue + movie.posterPath) {
            button.af.setImage(for: .normal, url: url)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
