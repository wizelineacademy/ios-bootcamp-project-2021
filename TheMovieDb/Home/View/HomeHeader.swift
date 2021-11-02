//
//  HeaderHome.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class HomeHeader: UICollectionReusableView {
    
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: HomeHeader.self)
    public var nameHeader: MovieGroupSections? {
        didSet {
            configureUI()
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        guard let nameHeader = self.nameHeader else {return}
        headerLabel.text = nameHeader.description
    }
    
}
