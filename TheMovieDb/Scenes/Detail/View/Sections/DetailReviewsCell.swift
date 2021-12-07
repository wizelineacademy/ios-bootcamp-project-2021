//
//  DetailReviewsCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 09/11/21.
//

import UIKit

protocol DetailReviewsCellDelegate: AnyObject {
    
    func didSelectReview(_ review: ReviewModel?)
}

final class DetailReviewsCell: UICollectionViewCell {
    
    static let identifier: String = "detail-reviews-cell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline,
                                          compatibleWith: nil)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: DetailReviewsFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var paginationView: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.15)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    weak var delegate: DetailReviewsCellDelegate?
    var reviewsModel: MovieReviewsModel? {
        didSet {
            titleLabel.text = reviewsModel?.title
            collectionView.reloadData()
            paginationView.numberOfPages = reviewsModel?.reviews.count ?? 0
            paginationView.currentPage = 0
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
    
    private func setup() {
        collectionView.register(RatingViewCell.self,
                                forCellWithReuseIdentifier: RatingViewCell.identifier)
        collectionView.dataSource = self
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(paginationView)
        setupTitleLabelConstraints()
        setupCollectionConstraints()
        setupPaginationConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    private func setupCollectionConstraints() {
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 180.0).isActive = true
    }
    
    private func setupPaginationConstraints() {
        paginationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        paginationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    static func getCellSize(title: String, _ collectionView: UICollectionView?) -> CGSize {
        let collectionWidth = collectionView?.bounds.width ?? 0
        let safeAreaLeft = collectionView?.safeAreaInsets.left ?? 0
        let safeAreaRight = collectionView?.safeAreaInsets.right ?? 0
        let safeArea = safeAreaLeft + safeAreaRight
        let labelWidth = 32 + safeArea
        let titleHeight = title.height(basedWidth: labelWidth,
                                       font: UIFont.preferredFont(forTextStyle: .headline,
                                                                  compatibleWith: nil))
        let collectionReviewHeight: CGFloat = 180.0
        let indicatorPageSize: CGFloat = 32
        let cellHeight = titleHeight + collectionReviewHeight + indicatorPageSize
        return CGSize(width: collectionWidth - safeArea, height: cellHeight)
    }
}

extension DetailReviewsCell: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        paginationView.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        paginationView.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension DetailReviewsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RatingViewCell = collectionView.reuse(identifier: RatingViewCell.identifier,
                                                        for: indexPath)
        cell.review = reviewsModel?.reviews[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewsModel?.reviews.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = reviewsModel?.reviews[indexPath.row]
        delegate?.didSelectReview(item)
    }
}
