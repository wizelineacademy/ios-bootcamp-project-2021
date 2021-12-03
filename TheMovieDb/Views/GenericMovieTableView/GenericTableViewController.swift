//
//  HomeTableViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 12/11/21.
//

import UIKit

protocol GenericTableViewDelegate: AnyObject {
    func selectedTableItem(movie: MovieViewModel)
    func didScroll()
}

class GenericTableViewController: UITableView {
  
    weak var delegateTable: GenericTableViewDelegate?
    private lazy var dataTableSource = makeDataSource()
    var arrMovies: [MovieViewModel] = [] {
        didSet {
            update()
        }
    }
    
    public init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        delegate = self
        self.register(GenericMovieTableViewCell.self, forCellReuseIdentifier: GenericMovieTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenericTableViewController {
    enum Section: CaseIterable {
        case movies
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, MovieViewModel> {
        return UITableViewDiffableDataSource(
            tableView: self,
            cellProvider: {  tableView, indexPath, movieItem in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: GenericMovieTableViewCell.reuseIdentifier,
                    for: indexPath) as? GenericMovieTableViewCell                else { fatalError("Could not create new cell") }
                cell.movie = movieItem
                return cell
            }
        )
    }

    func update() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(arrMovies, toSection: .movies)
            self.dataTableSource.apply(snapshot, animatingDifferences: true)
    }
}

extension GenericTableViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataTableSource.itemIdentifier(for: indexPath) else { return }
        delegateTable?.selectedTableItem(movie: item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateTable?.didScroll()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setNeedsLayout()
    }
}
