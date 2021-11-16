//
//  HomeCollectionViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 10/11/21.
//

import UIKit

class HomeViewController: UIViewController, HomeView {
    
    var arrMovies: [SectionMovie: [Movie]]!
    var dataSource: UICollectionViewDiffableDataSource<SectionMovie, Movie>! = nil
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = 0.33
        let groupFractionalHeight: Float = 0.30
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalHeight(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: "HeaderCollectionView.reuseIdentifier",
          alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private var latestSearch: String?
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a Movie", delegate: self)
        searchController.text = latestSearch
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    
    var movieHomeCollectionView: UICollectionView!
   
    var tableView: UITableView!
  
    func showEmptyState() {
        print("")
    }
    
    var presenter: HomeViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }
        self.navigationItem.title = "Movies"
        navbar.tintColor = .black
        navbar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navbar.prefersLargeTitles = true

        // Set up the searchController parameters.
        navigationItem.searchController = searchController
        definesPresentationContext = true
        presenter?.fetchAllMovieList()
    }
    
    func setUpCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: compositionalLayout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifer)
        collectionView.register(
          HeaderCollectionView.self,
          forSupplementaryViewOfKind: "HeaderCollectionView.reuseIdentifier",
          withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
        movieHomeCollectionView = collectionView
    }
    
    @objc func refresh() {
        presenter?.fetchAllMovieList()
    }
    
    func showMoviesHome(arrMovie: [SectionMovie: [Movie]]) {
        self.arrMovies = arrMovie
        setUpCollectionView()
        configureDataSource()
        movieHomeCollectionView.reloadData()
    }
    
    func showLoading() {
        print("")
    }
    
    func stopLoading() {
       
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <SectionMovie, Movie>(collectionView: movieHomeCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, movieItem: Movie) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LargeCollectionViewCell.reuseIdentifer,
                for: indexPath) as? LargeCollectionViewCell else { fatalError("Could not create new cell") }
            cell.title = movieItem.title
            cell.portraitPhotoURL = movieItem.posterPath
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath) -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionView.reuseIdentifier,
            for: indexPath) as? HeaderCollectionView else { fatalError("Cannot create header view") }

          supplementaryView.label.text = SectionMovie.allCases[indexPath.section].rawValue
          return supplementaryView
        }
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<SectionMovie, Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionMovie, Movie>()
        for (key, value) in arrMovies {
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        return snapshot
    }
    
}


extension HomeViewController: SearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
    }
    
    func updateSearchResults(for text: String) {
        //
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func subviews() {
        view.addSubview(tableView)
    }

    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

}


