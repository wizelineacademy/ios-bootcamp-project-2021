//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit

final class ReviewsViewModel {
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewsDetails] = []
    var showError: ((MovieError) -> Void)?
    var facade: MovieService
    init(facade: MovieService) {
        self.facade = facade
    }
    var reloadData: (() -> Void)?
    
    func reviewsMovie() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .reviews(id: id)) { [weak self] (response: Result<MovieResponse<ReviewsDetails>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let reviewsResponse):
                self.reviews = reviewsResponse.results ?? []
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case .failure(let failureResult):
                self.showError?(failureResult)
            }
        }
    }
}

final class ReviewsViewController: UIViewController  {
    
    var viewModel: ReviewsViewModel = .init(facade: MovieFacade())
   
    private var reviewsTableView: UITableView = {
        let reviewsTableView = UITableView()
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        return reviewsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        configureTableView()
        viewModel.reloadData = { [weak self] in self?.reviewsTableView.reloadData() }
        viewModel.reviewsMovie()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemRed
        view.addSubview(reviewsTableView)
        reviewsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        reviewsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reviewsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        reviewsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        reviewsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureTableView() {
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
    }
    
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.reviewsTableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = viewModel.reviews[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerReviewsDetail = ReviewsDetailViewController()
        let reviewSelected = viewModel.reviews[indexPath.row]
        viewControllerReviewsDetail.viewModel.review = reviewSelected
        navigationController?.pushViewController(viewControllerReviewsDetail, animated: true)
    }
}
