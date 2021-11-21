//
//  HeaderCollectionReusableView.swift
//  TheMovieDb
//
//  Created by developer on 04/11/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, CellIdentifierProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIView.animate(withDuration: 2) {
            self.titleLabel.alpha = 0
        }
        
        UIView.animate(withDuration: 2) {
            self.titleLabel.alpha = 1
        }
    }
    
    func setTopicTitle(topic: Topic) {
        self.titleLabel.text = "\(topic)".capitalized
    }
}
