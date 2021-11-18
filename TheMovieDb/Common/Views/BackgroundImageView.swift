//
//  BackgroundImageView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit.UIImageView

final class BackgroundImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        image = #imageLiteral(resourceName: "noImage")
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        backgroundColor = .darkGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
