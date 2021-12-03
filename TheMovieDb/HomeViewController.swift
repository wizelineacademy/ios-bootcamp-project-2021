//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 09/12/20.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    var viewMoreButton = UIButton()
    
    private var service = NetworkManager(urlSession: URLSession.shared)
    static let categoryHeaderUpcoming = TitleOfSection.upcoming.value
    let categoryHeaderUpcomingId = TitleOfSection.upcoming.value
    
    
    static let categoryHeaderNowPlaying = TitleOfSection.nowPlaying.value
    let categoryHeaderNowPlayingId = TitleOfSection.nowPlaying.value
    
    let request = MovieFacade()
    init(service: NetworkManager = NetworkManager(urlSession: URLSession.shared)) {
        super.init(collectionViewLayout: HomeViewController.createLayout())
        self.service = service
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
                section.orthogonalScrollingBehavior = .paging
                return section
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderOfSection.self, forSupplementaryViewOfKind: HomeViewController.categoryHeaderUpcoming, withReuseIdentifier: categoryHeaderUpcomingId)
        navigationItem.title = "Movies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request.delegate = self
        setUpLayout()
        request.getAllMovies()
    }
}

// MARK: - UICollectionView
extension HomeViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        request.section[section].movies.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        let movie = request.section[indexPath.section].movies[indexPath.row]
        let image = ImageForMovie()
        var path = ""
        if indexPath.section == 0 {
            path = movie.backdropPath ?? ""
        } else {
            path = movie.posterPath ?? ""
        }
       

        cell.imageView?.getImageWithNSCache(withURL: URL(string: image.createURLForImage(path: path) ))
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        request.section.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let identifier = categoryHeaderUpcomingId
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? HeaderOfSection else {
            return HeaderOfSection()
        }
        let sectionName = MoviesSections(rawValue: indexPath.section)
        header.label.text = sectionName?.description
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieSelected = request.section[indexPath.section].movies[indexPath.row]
        self.navigationController?.pushViewController(DetailViewController(), animated: false)
    }
}


extension HomeViewController: DataLoaded {
    func reloadData() {
        collectionView.reloadData()
    }
}
