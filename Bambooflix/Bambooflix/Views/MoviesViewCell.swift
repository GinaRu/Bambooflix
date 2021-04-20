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
    var buttons: [UIButton] = []
    var delegate: MoviesViewCellDelegate?
   
    func configure(with movies: [Movie], isRounded: Bool, sectionHeight: CGFloat) {
        boto1.imageView?.contentMode = .scaleAspectFill
        boto2.imageView?.contentMode = .scaleAspectFill
        boto3.imageView?.contentMode = .scaleAspectFill
        boto4.imageView?.contentMode = .scaleAspectFill
        boto5.imageView?.contentMode = .scaleAspectFill
        boto6.imageView?.contentMode = .scaleAspectFill
        if isRounded == true {
            let round = sectionHeight / 2
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
            boto1.layer.cornerRadius = 0
            boto2.layer.cornerRadius = 0
            boto3.layer.cornerRadius = 0
            boto3.layer.cornerRadius = 0
            boto4.layer.cornerRadius = 0
            boto5.layer.cornerRadius = 0
            boto6.layer.cornerRadius = 0
        }
        self.movies = movies
        updateCoverImages()

    }
    func setImageAt(movie: Movie, button: UIButton) {
        if let url = URL(string: Endpoints.movieImage.rawValue + movie.posterPath) {
            button.af.setImage(for: .normal, url: url)
            button.isHidden = false
        }
    }
    
    private func updateCoverImages() {
        
        buttons.forEach {
            $0.setImage(nil, for: .normal)
            $0.isHidden = true
        }
        
        zip(movies, buttons).forEach{ (movie, button) in
            setImageAt(movie: movie, button: button)
            
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
        if let delegate = delegate {
            delegate.didSelectMovie(movieId: movies[sender.tag].id)
        }
    }

    override func awakeFromNib() {
        buttons = [boto1, boto2, boto3, boto4, boto5, boto6]
        super.awakeFromNib()
    }
    
}
