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
        let url = URL(string: BaseURL.baseUrlForImage + movie.posterPath)
        imageView.kf.setImage(with: url)
    }

}
