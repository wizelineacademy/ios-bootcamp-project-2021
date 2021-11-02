//
//  ReviewsCollectionViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

private let reuseIdentifier = "Cell"

final class ReviewsCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        self.collectionView!.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reuseIdentifier )
        navigationItem.title = "Reviews"
    }
    
    // MARK: - Actions

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as? ReviewCell else {
            return ReviewCell()
        }
        
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width - 20, height: 50)
        let estimatedSizeCell = ReviewCell(frame: frame)
        
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width - 20, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        return .init(width: view.frame.width - 20, height: estimatedSize.height)
    }
}

// MARK: - UICollectionViewControllerDelegate
extension ReviewsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}
