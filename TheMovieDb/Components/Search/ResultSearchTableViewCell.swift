//
//  ResultSearchTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 06/11/21.
//

import UIKit

final class ResultSearchTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var imageResult: UIImageView?
  static let identifier = "ResultSearchTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "ResultSearchTableViewCell", bundle: nil)
  }
  func configure(movieTitle: String, posterPath: String?) {
    self.titleLabel?.text = movieTitle
    self.setupImage(posterPath: posterPath ?? "")
  }
  
  func setupImage(posterPath: String) {
    if let url = URL(string: posterPath) {
      imageResult?.kf.setImage(with: url)
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
