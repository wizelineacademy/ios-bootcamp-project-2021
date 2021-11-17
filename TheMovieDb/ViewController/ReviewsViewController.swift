//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit
import os.log

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
        os_log("ReviewsViewController did load!", log: OSLog.viewCycle, type: .debug)
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
