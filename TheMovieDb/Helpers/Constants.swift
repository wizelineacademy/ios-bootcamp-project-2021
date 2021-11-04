//
//  Constants.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 3/11/21.
//

import Foundation

struct Constants {
    // MARK: - Storyboard Ids
    static let viewControllerID = "ListMoviesViewController"
    static let searchTableViewControllerID = "SearchTableViewController"
    static let movieInfoViewControllerID = "MovieInfoViewController"
    static let reviewsViewControllerID = "ReviewsViewController"
    static let reviewDetailID = "reviewsDetailViewController"
    static let personDetailViewControllerID = "PersonDetailViewController"
    
    // MARK: - Cell
    static let cellIdentifier = "cell"
    
    // MARK: - Titles/Messages
    static let reviewsTitleBarButton = "Reviews"
    static let titleInitialTableView = "Show Movies"
    static let searchBarPlaceholder = "Search for movies or person"
    static let alertButton = "Dismiss"
    
    // MARK: - ImageURL
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
}
