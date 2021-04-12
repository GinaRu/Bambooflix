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
    
    @IBOutlet var moviesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        moviesManager.fetchMovieDiscover(success: { (movies) in
            self.movies = movies.results
            self.tableView.reloadData()
                    })
        
        moviesManager.fetchMovieDetails(movieId: 399566, success: { (movie) in
    })
        

    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedPosition: Int = indexPath.row
        
        
     performSegue(withIdentifier: "SegueToDetail", sender: nil)
         
         print("Has seleccionado la fila \(selectedPosition)")
     }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
    
    func moviesForSection(_ section: Int) -> [Movie]  {
        var moviesSorted = [Movie]()
        if let movies = movies {
            switch section {
            case 0:
                moviesSorted = movies.sorted{ $0.popularity > $1.popularity}
            case 1:
                moviesSorted = movies.sorted{ $0.releaseDate > $1.releaseDate}
            case 2:
                moviesSorted = movies.sorted{ $0.voteAverage > $1.voteAverage }
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
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let moviesCell = cell as! MoviesViewCell
        
        
        let section = indexPath.section
        moviesCell.configure(with: moviesForSection(section))
        
        return cell
     }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 160
     }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Populares"
        case 1: return "Recientes"
        case 2: return "Más votadas"
        case 3: return "Películas que te gustarán"
        case 4: return "Cine internacional"
        default:
            return "Próximamente....."
        }

    }



    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

}

