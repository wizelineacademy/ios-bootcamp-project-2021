//
//  MovieDetails.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 22/11/21.
//

import Foundation
import UIKit

final class DetailsView: UIView {
    
    let view = UIView(frame: .zero)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var posterImage = UIImageView()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
    }
}
