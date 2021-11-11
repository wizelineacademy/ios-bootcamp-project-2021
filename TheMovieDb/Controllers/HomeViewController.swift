//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 10/11/21.
//

import UIKit
import Kingfisher

class HomeViewController: UITableViewController {

    var moviesList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.rowHeight = 150
        let searchMovieRequest = GetMovieList()
        searchMovieRequest.getMoviesList(option: .trending) { [weak self] moviesResults in
            DispatchQueue.main.async {
                self?.moviesList = moviesResults.results
            }
        }
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = moviesList[indexPath.item].title
        
        if let posterPath = moviesList[indexPath.item].posterPath {
            let baseImageUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseImageUrl + posterPath)
            cell.imageView?.kf.setImage(with: imageUrl)
        }
        // tableView.reloadData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // print(moviesList[indexPath.item].title)
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
