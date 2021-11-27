//
//  HeaderCollectionViewCell.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell, CellIdentifierProtocol {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInfoWith(movie: MovieDetailProtocol) {
        guard let poster = movie.posterPath else {
            imageView.image = UIImage.moviePlaceholder
            return
        }
        let url = URL(string: BaseURL.baseUrlForImage + poster)
        imageView.kf.setImage(with: url)
        titleLabel.attributedText = AttributedTextCreator.textForMovieDetailInfo(movie: movie)
    }
}
