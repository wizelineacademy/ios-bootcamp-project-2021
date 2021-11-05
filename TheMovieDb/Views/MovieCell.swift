//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 04/11/21.
//
import UIKit
import Foundation

class MovieCell: UICollectionViewCell {
    // must call super
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // we have to implement this initializer, but will only ever use this class programmatically
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor, title: String) {
        self.backgroundColor = colour
        let titleLabel = UILabel()
        titleLabel.text = "Hello"
        addSubview(titleLabel)
    }
}
