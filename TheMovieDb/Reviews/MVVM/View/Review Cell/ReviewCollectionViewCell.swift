//
//  ReviewCollectionViewCell.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell, CellIdentifierProtocol {

    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInfoWith(viewModel: ReviewViewModelProtocol) {
        self.reviewLabel.attributedText = viewModel.formatReviewText()
    }

}
