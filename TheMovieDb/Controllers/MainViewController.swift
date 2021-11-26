//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import UIKit

class MainViewController: UIViewController{
    

    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainTableView: UITableView!
    
    private let mainViewModel = MainViewModel()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        let movie = mainViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.mainSegueIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mainSegueIdentifier {
            let destinationVC = segue.destination as! DetailViewController //as is the
            guard let indexPath = mainTableView.indexPathForSelectedRow else { return }
            destinationVC.MovieData = mainViewModel.cellForRowAt(indexPath: indexPath)
            
        }
    }

}
