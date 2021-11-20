//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 19/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private let client = MovieClient()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
    
    private func searchMovie(query: String?) {
        
        guard let query = query, !query.isEmpty else { return }
        
        client.getSearch(query: query, params: nil) { [weak self] (result) in
      
            switch result {
            case .success(let listOf):
                guard let movieResult = listOf?.results else { return }
                //print(movieFeedResult?.results)
                self?.movies = movieResult
                self?.searchTableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchMovie(query: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        self.movies = []

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.movies = []
        if searchText.isEmpty {

        }
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //movieManager.numberOfRowsInSection(section: section)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]//movieManager.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        //print(movie)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.searchSegueIdentifier, sender: self)
        //print(movieManager.cellForRowAt(indexPath: indexPath))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.searchSegueIdentifier {
            let destinationVC = segue.destination as! DetailViewController //as is the
            guard let indexPath = searchTableView.indexPathForSelectedRow else { return }
            destinationVC.MovieData = movies[indexPath.row]//movieManager.cellForRowAt(indexPath: indexPath)
        }
    }
}

