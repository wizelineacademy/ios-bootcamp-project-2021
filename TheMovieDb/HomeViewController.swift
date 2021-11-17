//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 09/12/20.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    var viewMoreButton = UIButton()

    let service = NetworkManager(urlSession: URLSession.shared)
    static let categoryHeaderUpcoming = "Upcoming"
    let categoryHeaderUpcomingId = "Upcoming"
    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection in
            if sectionNumber == 0 {
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                item.contentInsets.trailing = 10
                item.contentInsets.leading = 10
                item.contentInsets.bottom = 16
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 10
                item.contentInsets.bottom = 5
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 10
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderUpcoming, alignment: .topLeading)
                ]
                return section
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderOfSection.self, forSupplementaryViewOfKind: HomeViewController.categoryHeaderUpcoming, withReuseIdentifier: categoryHeaderUpcomingId)
        navigationItem.title = "Movies"

        let url = "/3/trending/movie/day"
        service.get(path: url) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func handleResponse(_ response: MovieList) {
        DispatchQueue.main.async {
            self.movies = response.results
        }
    }
}

// MARK: - UICollectionView
extension HomeViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        cell.label?.text = movies[indexPath.row].title
        return cell
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: categoryHeaderUpcomingId, for: indexPath) as! HeaderOfSection
        header.label.text = "Upcoming"
        return header
    }
}
