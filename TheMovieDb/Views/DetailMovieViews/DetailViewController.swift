//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 17/11/21.
//

import UIKit
import SwiftUI

final class DetailViewController: UIViewController, DetailView {
    
    var presenter: DetailViewPresenter?
  
    private lazy var movieDetailCollectionView: GenericMovieCollectionView<SectionMovieDetail> = {
        let movieDetailCollectionView = GenericMovieCollectionView<SectionMovieDetail>(frame: view.bounds)
        movieDetailCollectionView.delegateCollection = self
        return movieDetailCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(movieDetailCollectionView)
        presenter?.setUpMovie()
        presenter?.fetchAllMovieList()
    }
        
    func showLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
    
    func loadSectionMovies(listSection: [SectionMovieDetail: [AnyHashable]]) {
        movieDetailCollectionView.arrMovies = listSection
        movieDetailCollectionView.sections = Array(listSection.keys)
        movieDetailCollectionView.configureDataSource()
        movieDetailCollectionView.reloadData()
    }
    
    func configureMovie(movie: MovieViewModel) {
        movieDetailCollectionView.movieSelected = movie
    }
    
}

extension DetailViewController: GenericMovieCollectionViewDelegate {
    func selectedCollectionItem<T>(movie: T) {
        if ((movie.self as? ReviewViewModel) != nil), let item = movie.self as? ReviewViewModel {
            let vc = UIHostingController(rootView: CommentSwiftUIView(review: item))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
