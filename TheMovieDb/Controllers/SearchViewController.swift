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
    
    private var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
        
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchViewModel.searchMovie(with: searchBar.text) {
            self.searchTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        let movie = searchViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.searchSegueIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.searchSegueIdentifier {
            let destinationVC = segue.destination as! DetailViewController //as is the
            guard let indexPath = searchTableView.indexPathForSelectedRow else { return }
            destinationVC.MovieData = searchViewModel.cellForRowAt(indexPath: indexPath)
        }
    }
}

