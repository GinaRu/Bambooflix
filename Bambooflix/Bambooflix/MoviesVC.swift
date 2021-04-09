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
    
    
    
    let moviesManager = MoviesManager()
    
    private let reuseIdentifier = String(describing: MoviesViewCell.self)
    
    @IBOutlet var moviesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        moviesManager.fetchMovieDiscover(success: { (movies) in
                    })
        
        moviesManager.fetchMovieDetails(movieId: 399566, success: { (movie) in
        print(movie)
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
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MoviesViewCell
//cell.configure(with: )
                    
        return cell
             }

  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 160
     }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Películas que podrían gustarte"
        } else if section == 1 {
                return "Acción"
        } else if section == 2 {
                return "Clásicos de toda la vida"
        } else if section == 3 {
                return "Para disfrutar en familia"
        } else if section == 4 {
                return "Aventuras"
            } else {
        return "Títol de secció"
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

}

