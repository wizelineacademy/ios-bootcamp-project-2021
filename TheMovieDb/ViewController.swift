//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    var titleLabel: UILabel!
    var trendingTitleLabel: UILabel!
    var nowPlayingTitleLabel: UILabel!
    var popularTitleLabel: UILabel!
    var topRatedTitleLabel: UILabel!
    var upcomingTitleLabel: UILabel!
    var viewMoreButton = UIButton()
    var collectionView: UICollectionView!
    let service = NetworkManager(urlSession: URLSession.shared)
    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 25, left: 20, bottom: 10, right: 25)
        layout.itemSize = CGSize(width: 150, height: 200)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
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
extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCell {
            cell.label?.text = "\(movies[indexPath.row].title)"
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
    }
}
