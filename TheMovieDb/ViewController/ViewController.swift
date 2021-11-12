//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

final class MovieListViewModel {
    var movieListOption: MoviesOptions = .nowPlaying
    var reloadData: (() -> Void)?
    var showError: ((MovieError) -> Void)?
    var facade: MovieService
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init(facade: MovieService) {
        self.facade = facade
    }
    
    func loadMovies() {
        let endpoint: MovieListEndpoint
        switch movieListOption {
        case .trending:
            endpoint = .trending
        case .nowPlaying:
            endpoint = .nowPlaying
        case .popular:
            endpoint = .popular
        case .topRated:
            endpoint = .topRated
        case .upcoming:
            endpoint = .upcoming
        }
        facade.get(search: nil, endpoint: endpoint) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let sucessResult):
                guard let results = sucessResult.results else {
                    self.showError?(.invalidResponse)
                    return
                }
                self.movies = results
                
            case .failure(let failureResult):
                self.showError?(failureResult)
            }
        }
    }

}

final class ViewController: UIViewController {
    
    var viewModel: MovieListViewModel = .init(facade: MovieFacade())
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTableView()
        configureUI()
        setupNavigationBar()
        viewModel.reloadData = { [weak self] in self?.tableView.reloadData() }
        viewModel.loadMovies()
        viewModel.showError = { [weak self] error in self?.showErrorAlert(error) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func configureUI() {
        title = viewModel.movieListOption.title
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = viewModel.movies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerMovieInfo = MovieInfoViewController()
        viewControllerMovieInfo.viewModel.movieID = viewModel.movies[indexPath.row].id
        navigationController?.pushViewController(viewControllerMovieInfo, animated: true)
    }
}

