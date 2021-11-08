//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import UIKit

class MainViewController: UIViewController{
    
    
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainTableView: UITableView!
    
    var movieManager = MovieManager()
    var movieType = "now_playing"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadPopularMoviesData()
        
    }
    
    private func loadPopularMoviesData(){
        movieManager.fetchMoviesData(type: movieType) { [weak self] in
            self?.mainTableView.reloadData()
        }
    }

    
}

extension MainViewController {
    @IBAction func mainSegmentedControlPressed(_ sender: UISegmentedControl) {
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            movieType = "now_playing"
            loadPopularMoviesData()
        case 1:
            movieType = "popular"
            loadPopularMoviesData()
        case 2:
            movieType = "top_rated"
            loadPopularMoviesData()
        case 3:
            movieType = "upcoming"
            loadPopularMoviesData()
        default:
            break
        }
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieManager.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieCell
        let movie = movieManager.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}
