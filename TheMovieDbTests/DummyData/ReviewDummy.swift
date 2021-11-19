//
//  ReviewDummy.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 18/11/21.
//

import Foundation
@testable import TheMovieDb

struct ReviewDummy {
    
    var reviews: [Review] = []
    
    init() {
        let authorReview1 = AuthorReview(name: "", username: "NeoBrowser", avatarPath: nil, rating: nil)
        let review1 = Review(id: "51ea49fe760ee35ab1463677", author: "NeoBrowser", content: "124", createdAt: "51ea49fe760ee35ab1463677", updatedAt: "51ea49fe760ee35ab1463677", url: "https://www.themoviedb.org/review/51429fb419c29552f00f2f7b", authorDetails: authorReview1)
        reviews.append(review1)
        
        let authorReview2 = AuthorReview(name: "", username: "Rotem", avatarPath: "/https://secure.gravatar.com/avatar/46a1a92c7411a32e58148c83a9f596d7.jpg", rating: nil)
        let review2 = Review(id: "51ea49fe760ee35ab1463674", author: "Rotem", content: "lorem ipsum", createdAt: "51ea49fe760ee35ab1463677", updatedAt: "51ea49fe760ee35ab1463674", url: "https://www.themoviedb.org/review/51429fb419c29552f00f2f7b", authorDetails: authorReview2)
        reviews.append(review2)
        
        let authorReview3 = AuthorReview(name: "", username: "Wuchak", avatarPath: "/4KVM1VkqmXLOuwj1jjaSdxbvBDk.jpg", rating: 34)
        let review3 = Review(id: "5e00f61375110d0018d87572", author: "Wuchak", content: "124", createdAt: "5e00f61375110d0018d87572", updatedAt: "51ea49fe760ee35ab1463674", url: "https://www.themoviedb.org/review/51429fb419c29552f00f2f7b", authorDetails: authorReview3)
        reviews.append(review3)
    }
    
    func getSingleReview() -> Review {
        let indexRandom = Int.random(in: 0..<reviews.count)
        return reviews[indexRandom]
    }
    
    func getSpecificReview(index: Int) -> Review {
        return reviews[index]
    }
    
}
