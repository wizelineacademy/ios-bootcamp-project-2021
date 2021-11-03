//
//  FeedTypeCell.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 01/11/21.
//

import UIKit

final class FeedTypeCell: UICollectionViewCell {
    
    static let cellIdentifier = "FeedTypeCell"
    
    @IBOutlet weak var titleContainer: UIView!
    
    @IBOutlet weak var typeTitle: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleContainer.backgroundColor = .systemBlue
            } else {
                titleContainer.backgroundColor = .lightGray
            }
            
        }
    }
    
    func updateUI(withFeedTitle title: String) {
        typeTitle.text = title
        titleContainer.layer.cornerRadius = 10
    }
    
}
