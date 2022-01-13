//
//  MovieDetailViewControllerMVVM.swift
//  TheMovieDb
//
//  Created by Angel Coronado Quintero on 12/01/22.
//

import UIKit

class MovieDetailViewControllerMVVM: UIViewController, MovieDetailViewProtocol {
    var viewModel: MovieDetailViewModelProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bind()
        viewModel?.fetchAllDetailData()
    }
    
    func bind() {
        self.viewModel?.didFetchSimilarMovies = { similarMovies in
            print(similarMovies)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.viewModel?.didFetchMovieDetail = { movieDetail in
            print(movieDetail)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.viewModel?.didFailFetchingSimilarMovies = { error in
            print(error)
        }
        
        self.viewModel?.didFailFetchingMovieDetail = { error in
            print(error)
        }
    }
    
    func setUpView() {
        self.title = viewModel?.getScreenTitle()
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieDetail()
        collectionView.setup(dataSource: self)
        collectionView.setup(delegate: self)
        collectionView.registerNibForCellWith(name: HeaderCollectionViewCell.identifierToDeque)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
        let navigationItemReviews = UIBarButtonItem(image: UIImage(named: "reviews"), style: .plain, target: self, action: #selector(showReviewScreen))
        self.navigationItem.rightBarButtonItem = navigationItemReviews

    }
    
    @objc func showReviewScreen() {
        print("show reviews")
        viewModel?.showMovieReviews(view: self)
        
    }
   
}

extension MovieDetailViewControllerMVVM: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      //  let type = MovieDetailCellsLayout(rawValue: section)
        switch section {
        case 0:
            return self.viewModel?.movieDetail != nil ? 1 : 0
        case 1:
            return self.viewModel?.similarMovies?.results.count ?? 0

        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifierToDeque, for: indexPath) as? HeaderCollectionViewCell, let movie = self.viewModel?.movieDetail {
                cell.setInfoWith(movie: movie)
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifierToDeque, for: indexPath) as? MovieCollectionViewCell {
                if let movie = self.viewModel?.similarMovies?.results[indexPath.row] {
                cell.setInfoWith(movie: movie)
                }
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
}

extension MovieDetailViewControllerMVVM: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let movie = self.viewModel?.similarMovies?.results[indexPath.row] {
                viewModel?.showMovieDetailWith(movie: movie, from: self)
            }
        }
    }
}
