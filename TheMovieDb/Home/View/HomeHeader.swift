//
//  HeaderHome.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    
    let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
