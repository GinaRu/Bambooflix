//
//  ViewController.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 07/04/2021.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesVC: UITableViewController {

    private var movies: [Movie]?
    let moviesManager = MoviesManager()
    private let reuseIdentifier = String(describing: MoviesViewCell.self)
    var headerMovieId = Int()
    
    @IBAction func headerButton(_ sender: UIButton) {
     didSelectMovie(movieId: headerMovieId)
    }
    
    @IBOutlet var headerButtonOutlet: UIButton!
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet var profileButton: UIBarButtonItem!
    
    func configureCell() {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        moviesManager.fetchMovieDiscover(success: { (movies) in
            self.movies = movies.results
            self.tableView.reloadData()
            
            
            //Configuración imagen/ título header
            guard let movies = self.movies else { return }
            
            let randomMovie = movies.randomElement()
            
            guard let randomM = randomMovie else {return}
    
            self.setImageAtHeader(movie: randomM, button: self.headerButtonOutlet)
            self.headerTitleLabel.text = randomM.title.uppercased()
            self.headerMovieId = randomM.id
            
                    })

    }
    func moviesForSection(_ section: Int) -> [Movie]  {
        var moviesSorted = [Movie]()
        if let movies = movies {
            switch section {
            case 0:
                moviesSorted = movies.sorted { $0.popularity > $1.popularity}
            case 1:
                moviesSorted = movies.sorted { $0.releaseDate > $1.releaseDate}
            case 2:
                moviesSorted = movies.sorted { $0.voteAverage > $1.voteAverage }
            case 3:
                moviesSorted = movies.shuffled()
            case 4:
                moviesSorted = movies.filter {$0.originalLanguage != "en"}
                
            default:
                moviesSorted = movies
            }
        }
      return moviesSorted
    }
    func configureProfileSelected() {
        self.tableView.isHidden = MoviesViewModel.selectedProfile == nil
        
        if MoviesViewModel.selectedProfile == nil {
            performSegue(withIdentifier: "segueToSelectionProfile", sender: nil)
        }
        guard let nameImage = MoviesViewModel.selectedProfile?.imageName else { return }
        
        let image = UIImage(named: "\(nameImage)" + "_mini")
        profileButton.image = image

    }

    func setImageAtHeader(movie: Movie, button: UIButton) {
        if let url = URL(string: Endpoints.movieImage.rawValue + movie.backdropPath) {
            button.af.setBackgroundImage(for: .normal, url: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       configureProfileSelected()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let moviesCell = cell as! MoviesViewCell
        let section = indexPath.section
        guard let sectionType: SectionType = SectionType(rawValue: section) else {
            return cell
        }
        moviesCell.configure(with: moviesForSection(section), isRounded: sectionType.isCircular, sectionHeight: sectionType.rowHeight)
        moviesCell.delegate = self

        return cell
     }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let sectionType: SectionType = SectionType(rawValue: indexPath.section) else {
            return 150
        }
        return sectionType.rowHeight
  
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType: SectionType = SectionType(rawValue: section) else {
            return "missing title"
        }
        return sectionType.name
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
        
}

extension MoviesVC {
    enum SectionType: Int, CaseIterable {
        case mostPopular, recentlyAdded, mostVoted, discover, internationalMovies
        
        var name: String {
            switch self {
            case .mostPopular:
                return "  Populares"
            case .recentlyAdded:
                return "  Recientes"
            case .mostVoted:
                return "  Más votadas"
            case .discover:
                return "  Películas que te gustarán"
            case .internationalMovies:
                return "  Cine internacional"
            }
        }
        var rowHeight: CGFloat {
            switch self {
            case .mostPopular:
                return 250
            case .discover:
                return 150
            case .recentlyAdded:
                return 150
            case .mostVoted:
                return 120
            case .internationalMovies:
                return 150
            }
        }
        var isCircular: Bool {
            switch self {
            case .mostPopular: return false
            case .recentlyAdded:
                return false
            case .mostVoted:
                return true
            case .discover:
                return false
            case .internationalMovies:
                return false
            }
        }
    }
}

// Protocolo para poder saber qué button de la Cell hemos pulsado:
extension MoviesVC: MoviesViewCellDelegate {
    func didSelectMovie(movieId: Int) {
        MoviesViewModel.selectedMovieId = movieId
        performSegue(withIdentifier: "SegueToDetail", sender: nil)
    }

}


