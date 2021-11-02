//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewsDetails] = []
    var reviewsIdentifier = "cell"

    @IBOutlet weak var reviewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reviewsIdentifier)
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        
        reviewsMovie()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.reviewsTableView.dequeueReusableCell(withIdentifier: reviewsIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = reviews[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ReviewsDetail") as? ReviewsDetailViewController {
            let reviewSelected = reviews[indexPath.row]
            vc.review = reviewSelected
            navigationController?.pushViewController(vc, animated: true)
        }
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
                print(failureResult.localizedDescription)
            }
        }
    }
}
