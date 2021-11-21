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
        let url = URL(string: BaseURL.baseUrlForImage + movie.posterPath)
        imageView.kf.setImage(with: url)
        
        titleLabel.attributedText = AttributedTextCreator.textForMovieDetailInfo(movie: movie)
    }

}


