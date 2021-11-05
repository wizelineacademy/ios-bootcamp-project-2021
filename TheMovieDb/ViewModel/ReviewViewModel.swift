//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

import Foundation

struct ReviewViewModel {
    
    let review: Review
    
    var imageUrl: URL? {
        
        var safeUrl = review.authorDetails.avatarPath ?? MovieConst.defaultImage

        if safeUrl.prefix(1) == "/" {
            safeUrl.removeFirst()
        }
        
        return URL(string: safeUrl)
    }
    
    var content: String {
        review.content
    }
    
    var author: String {
        review.author
    }
}
