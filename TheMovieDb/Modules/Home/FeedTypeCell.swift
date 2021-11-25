//
//  FeedTypeCell.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 01/11/21.
//

import UIKit

final class FeedTypeCell: UICollectionViewCell {
    
    static let cellIdentifier = "FeedTypeCell"
    
    private lazy var titleContainer = UIView()
    
    private lazy var typeTitle = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleContainer.backgroundColor = .systemBlue
            } else {
                titleContainer.backgroundColor = .lightGray
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleContainer.layer.cornerRadius = 10
        titleContainer.backgroundColor = .lightGray
        contentView.addSubview(titleContainer)
        contentView.addSubview(typeTitle)
    }
    
    func activateConstraints() {
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        typeTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 5),
            typeTitle.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 10),
            typeTitle.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -10),
            typeTitle.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -5)
        ])
    }
    
    func updateUI(withFeedTitle title: String) {
        typeTitle.text = title
    }
    
}
