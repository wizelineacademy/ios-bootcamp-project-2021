//
//  PopularTableView.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit


class PopularTableView: UITableViewController {
    var populator: MovieResults?
    var movieManager = MovieManager()
    //This is just for testing
    var movieType = "popular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        movieManager.fetchMovies(movieType: movieType)
        
    }


}

// MARK: - Delegate fills populator with results

extension PopularTableView: MovieManagerDelegate{
    func didMoviesUpdate(_ movieManager: MovieManager, results: MovieResults) {
        populator = results
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

// MARK: - Extension table view populating

extension PopularTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows, just for testing, incomplete

        if let num_rows = populator?.movies.count {
            return num_rows
        }else{
            return 20
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let movie = populator?.movies[indexPath.row] {
            cell.setMovieInfo(movie: movie)
        }
        
        return cell
    }

    

    
    

    
}
