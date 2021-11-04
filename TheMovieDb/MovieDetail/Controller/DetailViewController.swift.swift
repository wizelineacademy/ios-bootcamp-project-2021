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
    var movies: [RelatedMovieSections: [Movie]] = [:]
    private let group = DispatchGroup()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchDataAPI()
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
    
    private func fetchDataAPI() {
        fetchData(typeMovieSection: .recommendations)
        fetchData(typeMovieSection: .similar)
        group.notify(queue: .main) {
            self.reloadCollectionView()
        }
    }
    
    private func fetchData(typeMovieSection: RelatedMovieSections) {
        group.enter()
        MovieAPI.shared.fetchData(endPoint: typeMovieSection.path, completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies[typeMovieSection] = res.movies
            }
            self.group.leave()
        })
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.reuseIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        
        navigationItem.title = movie.title
    }
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = RelatedMovieSections(rawValue: section) ?? .similar
        guard let movies = movies[section] else { return 0}
        return movies.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return RelatedMovieSections.allCases.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = RelatedMovieSections(rawValue: indexPath.section) ?? .similar
        guard let movies = movies[section] else { return DefaultSectionCell() }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell else {
            return DefaultSectionCell()
        }

        let movie =   movies[indexPath.row]
        let viewModel = MovieViewModel(movie: movie)
        cell.viewModel = viewModel
   
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let groupName = RelatedMovieSections(rawValue: indexPath.section)
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
        let section = RelatedMovieSections(rawValue: section)
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
        let controller = ReviewsCollectionViewController(with: movie)
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    
}

// MARK: - UICollectionViewControllerDelegate
extension DetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = RelatedMovieSections(rawValue: indexPath.section) ?? .similar
        guard let movies = movies[section] else { return }
        let movie =   movies[indexPath.row]
        
        let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
