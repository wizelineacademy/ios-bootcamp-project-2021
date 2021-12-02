//
//  EmptyMovieCell.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 01/12/21.
//

import UIKit

class NothingFoundView: UIView {
    
    lazy private var nothingFoundTitle: UILabel = {
        let view = UILabel()
        view.text = "No movies found"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .label
        return view
    }()
    
    // General margin for ui elements
    private let margin: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(nothingFoundTitle)
        
        NSLayoutConstraint.activate([
            nothingFoundTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            nothingFoundTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
