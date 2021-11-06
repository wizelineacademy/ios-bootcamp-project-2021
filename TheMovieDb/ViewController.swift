//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 25, left: 20, bottom: 10, right: 25)
//        layout.itemSize = CGSize(width: 20, height: 20)
        // collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        // SEND REQUEST TO SEARCH MOVIE BY ID
        let searchMovieRequest = SearchByIdRepo()
        searchMovieRequest.searchMovieById(id: 603) { movie in
            print(movie)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5 // numero de celdas, corresponde al numero de peliculas en una lista
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell {
            // cell.label?.text = "\(movies[indexPath.row].title)"
            cell.titleLabel?.text = "Movie title"
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
