//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainTableView: UITableView!
    
    private var mainViewModel = MainViewModel()
    var pageIndex: Int = 1
    
    init(mainViewModel: MainViewModel = MainViewModel()) {
        self.mainViewModel = mainViewModel
        super.init(nibName: Constants.mainViewControllerName, bundle: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupTableView(page: pageIndex)
        
    }
    
    // MARK: - Setup Table View from viewModel with completion in order to refresh the table view
    
    private func setupTableView(page: Int) {
        mainViewModel.loadMoviesData(with: mainSegmentedControl.selectedSegmentIndex, page: page) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.mainTableView.reloadData()
            }
        }
    }

}

// MARK: - Getting the segmented control ID, return pagination to 1 and reset the appended movies.

extension MainViewController {
    @IBAction func mainSegmentedControlPressed(_ sender: UISegmentedControl) {
        pageIndex = 1
        mainViewModel.resetMovies()
        setupTableView(page: pageIndex)
    }
}

// MARK: - Protocol to fill the Table View

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = mainViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let height = scrollView.frame.size.height
       let contentYoffset = scrollView.contentOffset.y
       let distanceFromBottom = scrollView.contentSize.height - contentYoffset
       if distanceFromBottom < height {
           pageIndex += 1
           setupTableView(page: pageIndex)
       }
    }
}

// MARK: - Table View Delegate to show the Detail View

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: Constants.detailViewControllerName) as? DetailViewController else { return }
        detailViewController.movieData = mainViewModel.cellForRowAt(indexPath: indexPath)
        show(detailViewController, sender: self)
    }
}
