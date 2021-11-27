//
//  MovieCollectionViewCell.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, CellIdentifierProtocol {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 10
    }
    
    func setInfoWith(movie: Movie) {
        guard let poster = movie.posterPath else {
            imageView.image = UIImage.moviePlaceholder
            return
        }
        let url = URL(string: BaseURL.baseUrlForImage + poster)
        imageView.kf.setImage(with: url)
    }

}
