//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView?
  private var reviews: [Review]?
  private var id: Int?
  weak var coordinator: MainCoordinator?
  
  init(id: Int) {
    super.init(nibName: "ReviewsViewController", bundle: nil)
    self.id = id
    self.requestAPI()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupUI()
  }
  func requestAPI() {
    ReviewsRequester().requestAPI(id: self.id ?? 0) { reviews in
      self.reviews = reviews
      self.tableView?.reloadData()
    }
  }
  func setupUI() {
    self.navigationItem.title = "Reviews"
  }
  
  func setupTableView() {
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
//    self.tableView?.showsVerticalScrollIndicator = false
//    self.tableView?.showsHorizontalScrollIndicator = false
    self.tableView?.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.reviews?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier) as? ReviewTableViewCell else {
      return ReviewTableViewCell()
    }
    cell.configure(author: self.reviews?[indexPath.row].author ?? "", rating: self.reviews?[indexPath.row].rating ?? 0, content: self.reviews?[indexPath.row].content ?? "")
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let review = self.reviews?[indexPath.row]
    coordinator?.showReviewDetail(author: review?
                                    .author ?? "", rating: review?.rating ?? 0, content: review?.content ?? "")
    tableView.deselectRow(at: indexPath, animated: true)
  }
   
}
