//
//  DetailRecommendationsCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 11/11/21.
//

import UIKit

final class DetailRecommendationsCell: UICollectionViewCell {
    
    static let identifier: String = "detail-recommendations-cell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline,
                                          compatibleWith: nil)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = DetailRecommendationsFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    var recommendations: MovieRecommendationsModel? {
        didSet {
            titleLabel.text = recommendations?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    static func getCellSize(collectionView: UICollectionView?) -> CGSize {
        let rightInset: CGFloat = collectionView?.safeAreaInsets.right ?? 0.0
        let leftInset: CGFloat = collectionView?.safeAreaInsets.left ?? 0.0
        let safeInsets: CGFloat = rightInset + leftInset
        let width: CGFloat = collectionView?.bounds.width ?? 0
        return CGSize(width: width - safeInsets, height: 240)
    }
}

extension DetailRecommendationsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendationCell = collectionView.reuse(identifier: RecommendationCell.identifier,
                                                            for: indexPath)
        cell.movie = recommendations?.recommendations[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations?.recommendations.count ?? 0
    }
}

private extension DetailRecommendationsCell {
    
    func setup() {
        collectionView.register(RecommendationCell.self,
                                forCellWithReuseIdentifier: RecommendationCell.identifier)
        collectionView.dataSource = self
        addSubview(titleLabel)
        addSubview(collectionView)
        setupTitleLabelConstraints()
        setupCollectionConstraints()
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    func setupCollectionConstraints() {
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
