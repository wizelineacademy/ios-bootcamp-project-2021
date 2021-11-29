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
    
    init(mainViewModel: MainViewModel = MainViewModel()) {
        self.mainViewModel = mainViewModel
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupTableView()
        
    }
    
    private func setupTableView() {
        mainViewModel.loadMoviesData(with: mainSegmentedControl.selectedSegmentIndex) {
            self.mainTableView.reloadData()
        }
    }

}

extension MainViewController {
    @IBAction func mainSegmentedControlPressed(_ sender: UISegmentedControl) {
        setupTableView()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = mainViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.movieData = mainViewModel.cellForRowAt(indexPath: indexPath)
        show(detailViewController, sender: self)
        // performSegue(withIdentifier: Constants.mainSegueIdentifier, sender: self)
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mainSegueIdentifier {
            let destinationVC = segue.destination as! DetailViewController
            guard let indexPath = mainTableView.indexPathForSelectedRow else { return }
            destinationVC.movieData = mainViewModel.cellForRowAt(indexPath: indexPath)
            
        }
    }*/

}
