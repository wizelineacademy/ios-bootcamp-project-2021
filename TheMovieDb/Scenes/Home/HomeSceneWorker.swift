//
//  HomeSceneWorker.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation

protocol HomeSceneLogic {
    var sections: [HomeSections] { get }
}

final class HomeSceneWorker {}

extension HomeSceneWorker: HomeSceneLogic {
    
    var sections: [HomeSections] {
        return HomeSections.allCases
    }
}
