//
//  GenericMovieTableViewCell.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 17/11/21.
//

import UIKit
import Kingfisher
class GenericMovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "cellGenericMovieTableViewCell"
    var movie: Movie? {
        didSet{
            setUpCell()
            setupUI()
        }
    }
    let stackContainerView = UIStackView()
    let titleLabel = UILabel()
    let starImageView = UIImageView()
    let releaseDateLabel = UILabel()
    let averageLabel = UILabel()
    let posterImageView = UIImageView()
    let contentContainer = UIView()
    
    private func setUpCell() {
        //titleLabel.text = movie?.title
        if let portraitPhotoURL = movie?.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(portraitPhotoURL)") {
            posterImageView.kf.setImage(with: url)
        }
        
        
        
    }
    
    private func setupUI(){
        
    }
    

}
