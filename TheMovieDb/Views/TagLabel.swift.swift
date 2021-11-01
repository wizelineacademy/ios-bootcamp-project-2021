//
//  TagLabel.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit.UIImageView

final class TagLabel: UILabel {
    
    init(colorBackground: UIColor = .blue) {
        super.init(frame: .zero)
        backgroundColor = colorBackground
        layer.cornerRadius = 10
        font = UIFont.boldSystemFont(ofSize: 12)
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
