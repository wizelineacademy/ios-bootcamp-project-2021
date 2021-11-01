//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var type: MovieListEndpoint?
    var typeTitle = ""
    var pageMovie = 0
    var resultsMovie: [Movie] = []
    var totalPagesMovie = 0
    var totalResultsMovie = 0
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = typeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadMovies()
    }
    
    
    private func loadMovies() {
        guard let type = type else {
            return
        }
        
        MovieFacade.get(endpoint: type) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let sucessResult):
                print(sucessResult)
                self.pageMovie = sucessResult.page ?? 0
                print(sucessResult.page ?? 0)
                
                self.resultsMovie = sucessResult.results ?? []
                print(sucessResult.results ?? [])
                
                self.totalPagesMovie = sucessResult.totalPages ?? 0
                print(sucessResult.totalPages ?? 0)
                
                self.totalResultsMovie = sucessResult.totalResults ?? 0
                print(sucessResult.totalResults ?? 0)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = resultsMovie[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vcMovieSelected = storyboard?.instantiateViewController(identifier: "MovieInfo") as? MovieInfoViewController {
            vcMovieSelected.movie = resultsMovie[indexPath.row]
            navigationController?.pushViewController(vcMovieSelected, animated: true)
            print("You selected cell number \(indexPath.row)")
        }
        
        
    }
    
}

