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
    var movieType = Constants.MovieLaunch.nowPlaying
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMoviesData()
        
    }
    
    private func loadMoviesData(){
        movieManager.fetchMoviesData(type: movieType) { [weak self] in
            self?.mainTableView.reloadData()
        }
    }

    
}

extension MainViewController {
    @IBAction func mainSegmentedControlPressed(_ sender: UISegmentedControl) {
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            movieType = Constants.MovieLaunch.nowPlaying
        case 1:
            movieType = Constants.MovieLaunch.popular
        case 2:
            movieType = Constants.MovieLaunch.topRated
        case 3:
            movieType = Constants.MovieLaunch.upcoming
        case 4:
            movieType = Constants.MovieLaunch.trending
        default:
            break
        }
        loadMoviesData()
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieManager.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        let movie = movieManager.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        //print(movie)
        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
        //print(movieManager.cellForRowAt(indexPath: indexPath))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            let destinationVC = segue.destination as! DetailViewController //as is the
            guard let indexPath = mainTableView.indexPathForSelectedRow else { return }
            destinationVC.MovieData = movieManager.cellForRowAt(indexPath: indexPath)
            
        }
    }

}
