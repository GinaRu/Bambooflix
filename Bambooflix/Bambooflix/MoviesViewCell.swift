//
//  moviesViewCell.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 07/04/2021.
//

import UIKit

protocol MoviesViewCellDelegate {
    func didSelectMovie(movieId: Int)
}

class MoviesViewCell: UITableViewCell {
    
    var movies: [Movie] = []
    var delegate: MoviesViewCellDelegate?
    
    func configure(with movies: [Movie], isRounded: Bool) {
        if isRounded == true {
            let round = boto1.frame.height / 2
            constraintBoto.isActive = false
            constraintBotoCuadrada.isActive = true
            boto1.layer.cornerRadius = round
            boto2.layer.cornerRadius = round
            boto3.layer.cornerRadius = round
            boto3.layer.cornerRadius = round
            boto4.layer.cornerRadius = round
            boto5.layer.cornerRadius = round
            boto6.layer.cornerRadius = round
            
        } else {
            constraintBoto.isActive = true
            constraintBotoCuadrada.isActive = false
        }
        
        if movies.count >= 6 {
        setImageAt(movie: movies[0], button: boto1)
        setImageAt(movie: movies[1], button: boto2)
        setImageAt(movie: movies[2], button: boto3)
        setImageAt(movie: movies[3], button: boto4)
        setImageAt(movie: movies[4], button: boto5)
        setImageAt(movie: movies[5], button: boto6)
            
            self.movies = movies
        }
    }
    func setImageAt(movie: Movie, button: UIButton) {
        if let url = URL(string: Endpoints.movieImage.rawValue + movie.posterPath) {
            button.af.setImage(for: .normal, url: url)
        }
    }
    
    @IBOutlet var constraintBoto: NSLayoutConstraint!
    @IBOutlet var constraintBotoCuadrada: NSLayoutConstraint!
    
    @IBOutlet var boto1: UIButton!
    @IBOutlet var boto2: UIButton!
    @IBOutlet var boto3: UIButton!
    @IBOutlet var boto4: UIButton!
    @IBOutlet var boto5: UIButton!
    @IBOutlet var boto6: UIButton!
    
    @IBAction func movieTouched(_ sender: UIButton) {
       // print(movies[sender.tag].id)
        if let delegate = delegate {
            delegate.didSelectMovie(movieId: movies[sender.tag].id)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
