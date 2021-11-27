//
//  MovieReviewResult.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation

// MARK: - MovieReviewResult
struct MovieReviewResult: Decodable {
    let id, page: Int?
    let results: [MovieReviewItem]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieReviewResult
struct MovieReviewItem: Decodable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Decodable {
    let name, username: String?
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

extension AuthorDetails {
    static let preview = AuthorDetails(
        name: "Gare",
        username: "garethmb",
        avatarPath: "https://secure.gravatar.com/avatar/3593437cbd05cebe0a4ee753965a8ad1.jpg",
        rating: nil)
}

extension MovieReviewItem {
    static let preview = MovieReviewItem(
        author: "garethmb",
        authorDetails: AuthorDetails.preview,
        content: "In a magical area of Columbia surrounded by mountains; exists a magical town watched over by the Madrigal family. The family lives in a magical home that is the center point for the community and is loved by the community.\r\n\r\nIn the new Disney film “Encanto”; audiences are told the story of how the family patriarch founded the community with a magical candle and how upon reaching a certain age; all members of her family receive a “gift” from the magical house which gives them an ability to help the community. From being able to heal with cooking to talking to the animals and super strength; the family Madrigal is the beloved pillar of the community.\r\n\r\nTo every rule there is an exception and young Mirabel (Stephanie Beatriz); is the only member of her family not to receive a gift of powers. As such she is seen as a pariah from the family and believes she is more tolerated than loved especially compared to her siblings who are endowed with amazing abilities.\r\n\r\nThings change when a new member of the family goes through the gifting ceremony; the first one since Mirabel was denied, and receives an amazing gift and basks in the love of the town and family. Mirabel has a vision of the house cracking and falling into ruin. She tries to warn her family but they see the house in its usual pristine condition and blame Mirabel for being jealous for not having a gift and wanting to take attention away from those who do.\r\n\r\nMirabel believes in what she saw and learns that members of her family may know more than they admit and that they hold the key to saving the day. This leads to a quest to find the absent Uncle Bruno (John Leguizamo); who has been absent as many believe his gift of prophecy only leads to bad things coming to fruition and has gone into hiding as a result.\r\n\r\nMirabel is soon forced to look deep inside herself and find her strength to overcome her own insecurities and save her family and community.\r\n\r\nThe film has great animation and is awash in color as it brings the magical community to life. The music is lively and is what you would expect from Lin- Manuel Miranda as it brings joy and energy to the film that is in keeping with the Disney tradition of amazing music in their animated films.\r\n\r\nThe biggest issue that I had with the film is that while fun and entertaining; the story never took the next step forward and at times dragged. This is not to say that “Encanto” is a bad film as it is lively, colorful, and fun; however it does not reach the heights of Disney classics like “Frozen” “Moana” and other classics. Think of it this way; “Lilo & Stitch” is a fine animated film but few would hold it in the same regard as “The Lion King”, “Beauty and the Beast”, and “The Little Mermaid”.\r\n\r\nIn the end “Encanto” offers a fun experience for the family and fans to enjoy and shows how even when they do not hit the top of the mountain; Disney is still the Gold Standard in animation.\r\n\r\n4 stars out of 5",
        createdAt: "2021-11-15T18:00:27.577Z",
        id: "6192a03b458199002a36d926",
        updatedAt: "2021-11-15T18:00:27.577Z",
        url: "https://www.themoviedb.org/review/6192a03b458199002a36d926")
}
