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
    static let reviewsTitleBarButton = "reviews.title.bar.button".localized
    static let titleInitialTableView = "title.initial.table.view".localized
    static let searchBarPlaceholder = "search.bar.placeholder".localized
    static let alertButton = "alert.button".localized
    static let alertEmptyRespone = "alert.empty.response".localized
    
    // MARK: - ImageURL
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
}
