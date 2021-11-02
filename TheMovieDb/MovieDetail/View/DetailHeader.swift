//
//  DetailHeader.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class DetailHeader: UICollectionReusableView {
    
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: DetailHeader.self)
    public var nameHeader: RelatedMovieSections? {
        didSet {
            configure()
        }
    }
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        headerLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    private func configure() {
        guard let nameHeader = self.nameHeader else {return}
        headerLabel.text = nameHeader.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
