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
        
        let layout = ColumnFlowLayout()
        
        let trendingVC = ListViewController(collectionViewLayout: layout)
        let trendingTitle = MovieFeed.trending.getNavigationTitle()
        let tabTrendingItem = UITabBarItem(title: trendingTitle, image: UIImage(systemName: "chart.bar"), tag: MovieFeed.trending.rawValue)
        trendingVC.title = trendingTitle
        trendingVC.tabBarItem = tabTrendingItem
        let navigationTrendingVC = UINavigationController(rootViewController: trendingVC)
        
        let nowPlayingVC = ListViewController(collectionViewLayout: layout)
        let nowPlayingTitle = MovieFeed.nowPlaying.getNavigationTitle()
        let tabNowPlayingItem = UITabBarItem(title: nowPlayingTitle, image: UIImage(systemName: "play.circle"), tag: MovieFeed.nowPlaying.rawValue)
        nowPlayingVC.title = nowPlayingTitle
        nowPlayingVC.tabBarItem = tabNowPlayingItem
        let navigationNowPlayingVC = UINavigationController(rootViewController: nowPlayingVC)
        
        let popularVC = ListViewController(collectionViewLayout: layout)
        let popularTitle = MovieFeed.popular.getNavigationTitle()
        let tabPopularItem = UITabBarItem(title: popularTitle, image: UIImage(systemName: "flame"), tag: MovieFeed.popular.rawValue)
        popularVC.title = popularTitle
        popularVC.tabBarItem = tabPopularItem
        let navigationPopularVC = UINavigationController(rootViewController: popularVC)
        
        let topRatedVC = ListViewController(collectionViewLayout: layout)
        let topRatedTitle = MovieFeed.topRated.getNavigationTitle()
        let tabTopRatedItem = UITabBarItem(title: topRatedTitle, image: UIImage(systemName: "star.circle"), tag: MovieFeed.topRated.rawValue)
        topRatedVC.title = topRatedTitle
        topRatedVC.tabBarItem = tabTopRatedItem
        let navigationTopRatedVC = UINavigationController(rootViewController: topRatedVC)
        
        let upcomingVC = ListViewController(collectionViewLayout: layout)
        let upcomingTitle = MovieFeed.upcoming.getNavigationTitle()
        let tabUpcomingItem = UITabBarItem(title: upcomingTitle, image: UIImage(systemName: "hourglass.badge.plus"), tag: MovieFeed.upcoming.rawValue)
        upcomingVC.title = upcomingTitle
        upcomingVC.tabBarItem = tabUpcomingItem
        let navigationUpcomingVC = UINavigationController(rootViewController: upcomingVC)
        
        viewControllers = [navigationTrendingVC, navigationNowPlayingVC, navigationPopularVC, navigationTopRatedVC, navigationUpcomingVC]
        selectedViewController = navigationTrendingVC
    }
}
