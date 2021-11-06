//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 04/11/21.
//
import UIKit
import Foundation

class MovieCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: self.bounds)
        //customise imageview
        imageView?.backgroundColor = UIColor.purple
        contentView.addSubview(imageView!)
        label = UILabel(frame: CGRect(x: 20, y: 20, width: self.bounds.width - 50, height: 20))
        //Customsize label
        label?.textColor = UIColor.white
        contentView.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
}
