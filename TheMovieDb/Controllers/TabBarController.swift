//
//  TabBarController.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 15/11/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let trendingVC = ListViewController()
        let trendingTitle = MovieFeed(feedType: .trending).getNavigationTitle()
        let tabTrendingItem = UITabBarItem(title: trendingTitle, image: UIImage(systemName: "chart.bar"), tag: FeedType.trending.rawValue)
        trendingVC.tabBarItem = tabTrendingItem
        let navigationTrendingVC = UINavigationController(rootViewController: trendingVC)
        
        let nowPlayingVC = ListViewController()
        let nowPlayingTitle = MovieFeed(feedType: .nowPlaying).getNavigationTitle()
        let tabNowPlayingItem = UITabBarItem(title: nowPlayingTitle, image: UIImage(systemName: "play.circle"), tag: FeedType.nowPlaying.rawValue)
        nowPlayingVC.tabBarItem = tabNowPlayingItem
        let navigationNowPlayingVC = UINavigationController(rootViewController: nowPlayingVC)
        
        let popularVC = ListViewController()
        let popularTitle = MovieFeed(feedType: .popular).getNavigationTitle()
        let tabPopularItem = UITabBarItem(title: popularTitle, image: UIImage(systemName: "flame"), tag: FeedType.popular.rawValue)
        popularVC.tabBarItem = tabPopularItem
        let navigationPopularVC = UINavigationController(rootViewController: popularVC)
        
        let topRatedVC = ListViewController()
        let topRatedTitle = MovieFeed(feedType: .topRated).getNavigationTitle()
        let tabTopRatedItem = UITabBarItem(title: topRatedTitle, image: UIImage(systemName: "star.circle"), tag: FeedType.topRated.rawValue)
        topRatedVC.tabBarItem = tabTopRatedItem
        let navigationTopRatedVC = UINavigationController(rootViewController: topRatedVC)
        
        let upcomingVC = ListViewController()
        let upcomingTitle = MovieFeed(feedType: .upcoming).getNavigationTitle()
        let tabUpcomingItem = UITabBarItem(title: upcomingTitle, image: UIImage(systemName: "hourglass.badge.plus"), tag: FeedType.upcoming.rawValue)
        upcomingVC.tabBarItem = tabUpcomingItem
        let navigationUpcomingVC = UINavigationController(rootViewController: upcomingVC)
        
        viewControllers = [navigationTrendingVC, navigationNowPlayingVC, navigationPopularVC, navigationTopRatedVC, navigationUpcomingVC]
        selectedViewController = navigationTrendingVC
    }
}
