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
    
    private let client = MovieClient()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMoviesData()
        
    }
    
    private func loadMoviesData(){
        client.getFeed(from: mainSegmentedControl.endpoint) { [weak self] (result) in
      
            switch result {
            case .success(let listOf):
                guard let movieResult = listOf?.results else { return }
                //print(movieFeedResult?.results)
                self?.movies = movieResult
                self?.mainTableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }

    
}

extension MainViewController {
    @IBAction func mainSegmentedControlPressed(_ sender: UISegmentedControl) {
        loadMoviesData()
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.setCellWithValuesOf(movie)
        //print(movie)
        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.mainSegueIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mainSegueIdentifier {
            let destinationVC = segue.destination as! DetailViewController //as is the
            guard let indexPath = mainTableView.indexPathForSelectedRow else { return }
            destinationVC.MovieData = movies[indexPath.row]
            
        }
    }

}
