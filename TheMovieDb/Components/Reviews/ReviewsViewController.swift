//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

final class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet private var tableView: UITableView?
  
//  private var reviews: [Review]?
  private var id: Int?
  weak var coordinator: MainCoordinator?
  
  private var reviewListViewModel: ReviewListViewModel?
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
  
  private func requestAPI() {
    ReviewsRequester(id: self.id ?? 0).requestAPI(completion: { reviews in
//      self.reviews = reviews
      self.reviewListViewModel = ReviewListViewModel(reviews)
      self.tableView?.reloadData()
    })
  }
  private func setupUI() {
    self.navigationItem.title = "Reviews"
  }
  
  private func setupTableView() {
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
//    self.tableView?.showsVerticalScrollIndicator = false
//    self.tableView?.showsHorizontalScrollIndicator = false
    self.tableView?.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.reviewListViewModel?.numberRows() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier) as? ReviewTableViewCell else {
      return ReviewTableViewCell()
    }
    cell.configure(self.reviewListViewModel?.reviewAtIndex(indexPath.row))
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let reviewViewModel = self.reviewListViewModel?.reviewAtIndex(indexPath.row)
    coordinator?.showReviewDetail(reviewViewModel)
    tableView.deselectRow(at: indexPath, animated: true)
  }
   
}
