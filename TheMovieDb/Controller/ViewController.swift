//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var type: MovieListEndpoint?
    var typeTitle = ""
    var resultsMovie: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = typeTitle
        configureTableView()
        setupNavigationBar()
        loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadMovies() {
        guard let type = type else { return }
        
        MovieFacade.get(endpoint: type) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let sucessResult):
                guard let results = sucessResult.results else {
                    self.showErrorAlert(.invalidResponse)
                    return
                }
                self.resultsMovie = results
                print(sucessResult.results ?? [])
                
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = resultsMovie[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewControllerMovieInfo = storyboard?.instantiateViewController(identifier: Constants.movieInfoViewControllerID) as? MovieInfoViewController {
            viewControllerMovieInfo.movie = resultsMovie[indexPath.row]
            navigationController?.pushViewController(viewControllerMovieInfo, animated: true)
        }
    }
}

