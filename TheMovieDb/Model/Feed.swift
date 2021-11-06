//
//  Feed.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import Foundation

protocol FeedProtocol {
    associatedtype key: Hashable
    associatedtype value
    var listsOfElements: [key: value] { get set }

}

struct MoviesFeed: FeedProtocol {
    var listsOfElements: [Topic: MovieList]
    typealias key = Topic
    typealias value = MovieList
    
    mutating func addList(topic: Topic, movieList: MovieList) {
        listsOfElements[topic] = movieList
    }
}
