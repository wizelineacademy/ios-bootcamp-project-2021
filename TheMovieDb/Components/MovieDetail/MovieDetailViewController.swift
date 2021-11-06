//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 31/10/21.
//

import UIKit

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChangeViewDelegate {
  
  @IBOutlet weak var posterImageView: UIImageView?
  @IBOutlet weak var informationView: UIView?
  @IBOutlet weak var votingLabel: UILabel?
  @IBOutlet weak var overviewLabel: UILabel?
  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var showReviewsButton: UIButton?
  
  private var movieId: Int
  private var posterPath: String
  private var movieTitle: String
  private var movieScore: Float
  private var movieOverview: String
  
  weak var coordinator: MainCoordinator?
  
  init(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    self.posterPath = posterPath
    self.movieScore = movieScore
    self.movieTitle = movieTitle
    self.movieOverview = overview
    self.movieId = id
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
  
  func setupUI() {
    self.setupImage(posterPath: self.posterPath)
    self.navigationItem.title = self.movieTitle
    self.votingLabel?.text = "Score: \(self.movieScore)"
    self.overviewLabel?.text = self.movieOverview
    self.showReviewsButton?.titleLabel?.text = "Reviews"
  }
  func setupTable() {
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
    self.tableView?.separatorStyle = .none
    self.tableView?.isScrollEnabled = false
    self.tableView?.showsVerticalScrollIndicator = false
    self.tableView?.showsHorizontalScrollIndicator = false
    self.tableView?.register(RecommendedTableViewCell.nib(), forCellReuseIdentifier: RecommendedTableViewCell.identifier)
  }
  
  func setupImage(posterPath: String) {
    print(posterPath)
    if let url = URL(string: posterPath) {
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
    cell.configure(title: RecommendationsText.allCases[indexPath.row].rawValue, type: Recommendations.allCases[indexPath.row], id: movieId )
    
    return cell
  }
  
  func changeDetailVC(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    coordinator?.showDetailMovie(movieTitle: movieTitle, movieScore: movieScore, posterPath: posterPath, overview: overview, id: id)
  }
  @IBAction func reviewsTapped(_ sender: Any) {
    coordinator?.showReviews(id: self.movieId)
  }
  
}
