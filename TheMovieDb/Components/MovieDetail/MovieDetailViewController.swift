//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 31/10/21.
//

import UIKit

final class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChangeViewDelegate {
  
  @IBOutlet private var posterImageView: UIImageView?
  @IBOutlet private var informationView: UIView?
  @IBOutlet private var votingLabel: UILabel?
  @IBOutlet private var overviewLabel: UILabel?
  @IBOutlet private var tableView: UITableView?
  @IBOutlet private var showReviewsButton: UIButton?
  
//  private var movieId: Int
//  private var posterPath: String
//  private var movieTitle: String
//  private var movieScore: Float
//  private var movieOverview: String
  
  private var movieViewModel: MovieViewModel?
  
  weak var coordinator: MainCoordinator?
  
  init(movieViewModel: MovieViewModel?) {
    self.movieViewModel = movieViewModel
    super.init(nibName: "MovieDetailViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTable()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    self.showReviewsButton?.titleLabel?.text = "Reviews"
  }
  
  private func setupUI() {
    self.setupImage(posterPath: self.movieViewModel?.posterPath)
    self.navigationItem.title = self.movieViewModel?.title
    self.votingLabel?.text = "Score: \(self.movieViewModel?.score ?? 0)"
    self.overviewLabel?.text = self.movieViewModel?.overview
    self.showReviewsButton?.titleLabel?.text = "Reviews"
  }
  private func setupTable() {
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
    self.tableView?.separatorStyle = .none
    self.tableView?.isScrollEnabled = false
    self.tableView?.showsVerticalScrollIndicator = false
    self.tableView?.showsHorizontalScrollIndicator = false
    self.tableView?.register(RecommendedTableViewCell.nib(), forCellReuseIdentifier: RecommendedTableViewCell.identifier)
  }
  
  private func setupImage(posterPath: String?) {
    if let url = URL(string: posterPath ?? "") {
      posterImageView?.kf.setImage(with: url)
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Recommendations.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: RecommendedTableViewCell.identifier) as? RecommendedTableViewCell else {
      return RecommendedTableViewCell()
    }
    cell.delegate = self
    cell.configure(title: RecommendationsText.allCases[indexPath.row].rawValue, type: Recommendations.allCases[indexPath.row], id: self.movieViewModel?.id ?? 0 )
    
    return cell
  }
  
  func changeDetailVC(movieViewModel: MovieViewModel?) {
    coordinator?.showDetailMovie(movieViewModel ?? nil)
  }
  @IBAction func reviewsTapped(_ sender: Any) {
    coordinator?.showReviews(id: self.movieViewModel?.id ?? 0)
  }
  
}
