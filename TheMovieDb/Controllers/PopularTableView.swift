//
//  PopularTableView.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit


class PopularTableView: UITableViewController {
    //var populator = [Movie]()
    var movieManager = MovieManager()
    //This is just for testing
    var movieType = "popular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        //movieManager.delegate = self
        //movieManager.fetchMovies(movieType: movieType)
        //tableView.reloadData()
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData(){
        movieManager.fetchMoviesData(type: movieType) { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // return the number of rows, just for testing, incomplete
        movieManager.numberOfRowsInSection(section: section)
        
           
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieCell
           
           let movie = movieManager.cellForRowAt(indexPath: indexPath)
           cell.setCellWithValuesOf(movie)
           return cell
       }
    
    
}

