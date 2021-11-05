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
    public var movie: Movie
    private var reviews = [Review]()
    
    // MARK: - LifeCycle
    init(with movie: Movie) {
        self.movie = movie
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchDataAPI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        self.collectionView!.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reusableIdentifier )
        navigationItem.title = "Reviews"
        collectionView.backgroundColor = .systemBackground
    }
    
    // MARK: - API
    
    private func fetchDataAPI() {
        let id = String(movie.id)
        let parameter = APIParameters(id: id)
        MovieAPI.shared.fetchData(endPoint: .review, with: parameter, completion: {(response: Result<Reviews, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.reviews = res.reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
       
        })
    }
    
}

// MARK: UICollectionViewDataSource
extension ReviewsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return reviews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reusableIdentifier, for: indexPath) as? ReviewCell else {
            return ReviewCell()
        }
        let review = reviews[indexPath.row]
        let viewModel = ReviewViewModel(review: review)
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 200)
    }
}

// MARK: - UICollectionViewControllerDelegate
extension ReviewsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        let controller = ReviewDescriptionViewController()
        controller.review = review
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
