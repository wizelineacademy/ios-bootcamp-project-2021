//
//  DetailViewController.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    // MARK: - Properties
    public var movie: Movie
    private var similarMovies = [Movie]()
    private var recommendationsMovies = [Movie]()
    private let group = DispatchGroup()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchDataAPI()
    }
    
    private func fetchDataAPI() {
        fetchSimilar()
        fetchRecommendation()
        group.notify(queue: .main) {
            self.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView() {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    init(with movie: Movie) {
        self.movie = movie
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 100, height: 140)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    public func fetchSimilar() {
        group.enter()
        MovieAPI.shared.getRecommendations(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.recommendationsMovies = res.movies
            }
            self.group.leave()
        })
    }
    
    public func fetchRecommendation() {
        group.enter()
        MovieAPI.shared.getSimilar(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.similarMovies = res.movies
                // self.reloadCollectionView(groupSection: .topRated)
            }
            self.group.leave()
        })
    }
    
    // MARK: - Helpers
    private func configureUI() {
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.reuseIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.reuseIdentifier)
        
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        
        navigationItem.title = movie.title
    }
    
    // MARK: - Actions
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieSections(rawValue: section)
        
        switch section {
        case .recommendations:
            return recommendationsMovies.count
        case .similar:
            return similarMovies.count
        case .none:
            return 0
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell else {
            return DefaultSectionCell()
        }
        if indexPath.section == 0 {
            let movie = recommendationsMovies[indexPath.row]
            cell.withMovie(with: movie)
        }else {
            let movie = similarMovies[indexPath.row]
            cell.withMovie(with: movie)
        }
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let groupName = MovieSections(rawValue: indexPath.section)
        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeaderView.reuseIdentifier, for: indexPath) as? DetailHeaderView else {
                return DetailHeaderView()
            }
            header.movie = movie
            header.delegate = self
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.reuseIdentifier, for: indexPath) as? DetailHeader else {
                return DetailHeader()
            }
            header.nameHeader = groupName
            return header
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = MovieSections(rawValue: section)
        switch section {
        case .recommendations:
            return CGSize(width: view.frame.height, height: 500)
        case .similar:
            return CGSize(width: view.frame.height, height: 50)
        case .none:
            return CGSize(width: view.frame.height, height: 0)
        }
        

        
    }
}

// MARK: - DetailHeaderViewDelegate
extension DetailViewController: DetailHeaderViewDelegate {
    func openReviews(_ detailHeaderView: DetailHeaderView, with movie: Movie) {
        let controller = ReviewsCollectionViewController()
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewControllerDelegate
extension DetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        if indexPath.section == 0 {
            movie = recommendationsMovies[indexPath.row]
        } else {
            movie = similarMovies[indexPath.row]
        }
        
        let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
