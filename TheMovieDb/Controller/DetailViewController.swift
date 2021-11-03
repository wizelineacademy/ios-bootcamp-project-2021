//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/3/21.
//

import Foundation
import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  
  var movie: MovieDetails?
  
  var baseUrlImage = "https://image.tmdb.org/t/p/w500/"
  
  @IBOutlet private weak var heroImage: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var releaseDateLabel: UILabel!
  @IBOutlet private weak var userScoreLabel: UILabel!
  @IBOutlet private weak var starIcon: UIImageView!
  @IBOutlet private weak var scoreLabel: UILabel!
  @IBOutlet private weak var overviewLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var languageLabel: UILabel!
  @IBOutlet private weak var statusLabel: UILabel!
  @IBOutlet private weak var budgetLabel: UILabel!
  @IBOutlet private weak var revenueLabel: UILabel!
  @IBOutlet private weak var backgroundImage: UIImageView!
  @IBOutlet private weak var backgroundInfo: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDetailMovie()
  }
  
  func setupDetailMovie() {
    
    guard let title = movie?.title,
          let heroImage = movie?.poster,
          let releaseDate = movie?.releaseDate,
          let score = movie?.voteAverage,
          let description = movie?.overview,
          let originalLanguage = movie?.originalLanguage,
          let status = movie?.status,
          let budget = movie?.budget,
          let revenue = movie?.revenue,
          let backgroudImage = movie?.backDropPath
            
    else { return }
    
    self.title = title
    
    let date = releaseDate.components(separatedBy: "-")
    let month = SetMonth.Jan

    self.starIcon.tintColor = DesignColor.white.color
    self.titleLabel.text = title
    self.heroImage.layer.cornerRadius = 10
    self.releaseDateLabel.text = month.setMonth(date: date)
    let urlPost = URL(string: "\(baseUrlImage)\(heroImage)")
    let imageProvider = ImageResource(downloadURL: urlPost!)
    self.heroImage.kf.setImage(with: imageProvider)
    let urlBackground = URL(string: "\(baseUrlImage)\(backgroudImage)")
    let backgroundProvider = ImageResource(downloadURL: urlBackground!)
    self.backgroundImage.kf.setImage(with: backgroundProvider)
    self.backgroundInfo.backgroundColor = DesignColor.black.color
    self.scoreLabel.text = String(score)
    self.descriptionLabel.text = description
    self.languageLabel.text = originalLanguage
    self.statusLabel.text = status
    self.budgetLabel.text = "$\(budget)"
    self.revenueLabel.text = "$\(revenue)"
    
  }
  
}
