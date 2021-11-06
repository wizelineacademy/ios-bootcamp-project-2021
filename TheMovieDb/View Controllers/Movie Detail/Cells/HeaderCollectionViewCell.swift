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
    
    func setInfoWith(movie: Movie) {
        let url = URL(string: BaseURL.baseUrlForImage + movie.posterPath)
        imageView.kf.setImage(with: url)
        titleLabel.text = movie.title + "\n" + movie.overview
    }

}
