//
//  DetailOverviewCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 05/11/21.
//

import UIKit

final class DetailOverviewCell: UICollectionViewCell {
    
    static let identifier: String = "detail-overview-cell"
    
    private lazy var stackLabels: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var overview: MovieOverviewModel? {
        didSet {
            titleLabel.text = overview?.title
            overviewLabel.text = overview?.overview
        }
    }
    
    func setup() {
        addSubview(stackLabels)
        stackLabels.addArrangedSubview(titleLabel)
        stackLabels.addArrangedSubview(overviewLabel)
        setupStackLabelConstraints()
    }
    
    static func getCellSize(overview: MovieOverviewModel?,
                            _ collectionView: UICollectionView?) -> CGSize {
        guard let item = overview else { return .zero }
        let rightInset: CGFloat = collectionView?.safeAreaInsets.right ?? 0.0
        let leftInset: CGFloat = collectionView?.safeAreaInsets.left ?? 0.0
        let safeSpaces = rightInset + leftInset
        let horizontalSpaces: CGFloat = 32 + safeSpaces
        let verticalSpaces: CGFloat = 24
        let width: CGFloat = collectionView?.bounds.width ?? 0
        let labelWidth: CGFloat = width - horizontalSpaces
        let titleHeight = item.title?.height(basedWidth: labelWidth,
                                             font: UIFont.preferredFont(forTextStyle: .headline)) ?? 0
        let overviewHeight = item.overview?.height(basedWidth: labelWidth,
                                                   font: UIFont.preferredFont(forTextStyle: .body)) ?? 0
        let height: CGFloat = verticalSpaces + titleHeight + overviewHeight
        return CGSize(width: width - safeSpaces, height: height)
    }
}

private extension DetailOverviewCell {
    
    func setupStackLabelConstraints() {
        stackLabels.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackLabels.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        stackLabels.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
