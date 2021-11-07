//
//  ReviewTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet weak var authorLabel: UILabel?
  @IBOutlet weak var contentLabel: UILabel?
  @IBOutlet weak var ratingLabel: UILabel?
  
  static let identifier = "ReviewTableViewCell"
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "ReviewTableViewCell", bundle: nil)
  }
  
  func configure(author: String, rating: Float, content: String) {
    self.authorLabel?.text = author
    self.ratingLabel?.text = "\(rating)"
    self.contentLabel?.text = content
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
