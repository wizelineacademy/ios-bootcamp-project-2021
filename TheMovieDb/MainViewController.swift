//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

class MainViewController: UIViewController {
  
  var trendingMovies: [Movie] = []
  var nowPlayingMovies: [Movie] = []
  var popularMovies: [Movie] = []
  var topRatedMovies: [Movie] = []
  var upcomingMovies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    // Do any additional setup after loading the view.
    requestAPI()
    
  }
  
  func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "MovieDB"
    
  }
  
  func requestAPI() {
    let completion: (Result<MoviesResponse, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.trendingMovies = response.results
        default:
          self?.trendingMovies = []
        }
    }
    APIs.getTrendingMovies.resume(completion: completion)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
