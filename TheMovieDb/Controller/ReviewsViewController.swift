//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit

final class ReviewsViewController: UIViewController  {
    
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewsDetails] = []
    

    @IBOutlet weak var reviewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTableView()
        reviewsMovie()
    }
    
    func reviewsMovie() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .reviews(id: id)) { [weak self] (response: Result<MovieResponse<ReviewsDetails>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let reviewsResponse):
                self.reviews = reviewsResponse.results ?? []
                DispatchQueue.main.async {
                    self.reviewsTableView.reloadData()
                }
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
            }
        }
    }
    
    func configureTableView() {
        reviewsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }
    
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.reviewsTableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = reviews[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewControllerReviewsDetail = storyboard?.instantiateViewController(identifier: Constants.reviewDetailID) as? ReviewsDetailViewController {
            let reviewSelected = reviews[indexPath.row]
            viewControllerReviewsDetail.review = reviewSelected
            navigationController?.pushViewController(viewControllerReviewsDetail, animated: true)
        }
    }
}
