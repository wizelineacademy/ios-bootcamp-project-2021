//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit
import Kingfisher

final class MyMovieViewController: UITableViewController {
    
    var moviesList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        let searchMovieRequest = GetMovieList()
        searchMovieRequest.getMoviesList(option: .trending) { [weak self] moviesResults in
            DispatchQueue.main.async {
                self?.moviesList = moviesResults.results
            }
        }
    }
    
}

extension MyMovieViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = moviesList[indexPath.item].title
        
        if let posterPath = moviesList[indexPath.item].posterPath {
            let baseImageUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseImageUrl + posterPath)
            // print(movieUrl)
            cell.imageView?.kf.setImage(with: imageUrl)
//
//            let imageView = UIImageView()
//            imageView.kf.setImage(with: imageUrl)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // print(moviesList[indexPath.item].title)
    }
    
}
