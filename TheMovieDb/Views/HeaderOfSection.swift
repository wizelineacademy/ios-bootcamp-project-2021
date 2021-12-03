//
//  Header.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 11/11/21.
//

import Foundation
import UIKit

final class HeaderOfSection: UICollectionReusableView {
    let label = UILabel()
    public var title: MoviesSections? {
        didSet {
            setSectionName()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = .systemFont(ofSize: 26, weight: .bold)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSectionName() {
        guard let title = self.title else { return }
        label.text = title.description
    }
}
