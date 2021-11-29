//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 17/11/21.
//

import UIKit

final class DetailViewController: UIViewController, DetailView {
    
    var presenter: DetailViewPresenter?
    private var movieDetailCollectionView: GenericMovieCollectionView<SectionMovieDetail>!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        setUpCollectionView()
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
        print(Array(listSection.keys))
        movieDetailCollectionView.configureDataSource()
        movieDetailCollectionView.reloadData()
    }
    
    func configureMovie(movie: MovieViewModel) {
        movieDetailCollectionView.movieSelected = movie
    }
    
    func setUpCollectionView() {
        movieDetailCollectionView = GenericMovieCollectionView<SectionMovieDetail>(frame: view.bounds)
        movieDetailCollectionView.configureDataSource()
        view.addSubview(movieDetailCollectionView)
    }
    
}
