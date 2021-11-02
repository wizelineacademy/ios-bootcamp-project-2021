//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 01/11/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let cellIdentifier = "MovieCell"

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.backgroundColor = UIColor.secondarySystemFill.cgColor
    }
}
