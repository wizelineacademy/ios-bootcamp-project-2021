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
    var movieType = K.MovieLaunch.nowPlaying
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: K.cellXibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
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
            movieType = K.MovieLaunch.nowPlaying
            loadPopularMoviesData()
        case 1:
            movieType = K.MovieLaunch.popular
            loadPopularMoviesData()
        case 2:
            movieType = K.MovieLaunch.topRated
            loadPopularMoviesData()
        case 3:
            movieType = K.MovieLaunch.upcoming
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MovieCell
        let movie = movieManager.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}
