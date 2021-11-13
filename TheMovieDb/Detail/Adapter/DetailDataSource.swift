//
//  DetailDataSource.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 05/11/21.
//

import Foundation
import UIKit

protocol DataSourceProtocol {
    var items: [AnyHashable] { get }
    
    func collectionView(_ collectionView: UICollectionView?,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell?
    
    func collectionView(_ collectionView: UICollectionView?,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
}

final class DetailDataSource: DataSourceProtocol {
    var items: [AnyHashable] = []
    
    private let item: MovieModel
    
    init(item: MovieModel) {
        self.item = item
        items.append(MovieRatingModel(rating: item.voteAverage,
                                      popularity: item.popularity,
                                      voteCount: item.voteCount))
        items.append(MovieOverviewModel(title: "Overview",
                                        overview: item.overview))
    }
    
    func collectionView(_ collectionView: UICollectionView?, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let item = items[indexPath.row]
        switch item {
        case is MovieRatingModel:
            let cell = collectionView?
                .dequeueReusableCell(withReuseIdentifier: DetailRatingCell.identifier,
                                     for: indexPath) as? DetailRatingCell
            cell?.movie = item as? MovieRatingModel
            return cell
        case is MovieOverviewModel:
            let cell = collectionView?
                .dequeueReusableCell(withReuseIdentifier: DetailOverviewCell.identifier,
                                     for: indexPath) as? DetailOverviewCell
            cell?.overview = item as? MovieOverviewModel
            return cell
        case is MovieReviewsModel:
            let cell = collectionView?
                .dequeueReusableCell(withReuseIdentifier: DetailReviewsCell.identifier,
                                  for: indexPath) as? DetailReviewsCell
            let item = item as? MovieReviewsModel
            cell?.reviewsModel = item
            return cell
        case is MovieRecommendationsModel:
            let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: DetailRecommendationsCell.identifier,
                                                           for: indexPath) as? DetailRecommendationsCell
            let item = item as? MovieRecommendationsModel
            cell?.recommendations = item
            return cell
        default:
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView?, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        switch item {
        case is MovieRatingModel:
            return DetailRatingCell.getCellSize(collectionView: collectionView)
        case is MovieOverviewModel:
            let item = item as? MovieOverviewModel
            return DetailOverviewCell.getCellSize(overview: item, collectionView)
        case is MovieReviewsModel:
            return DetailReviewsCell.getCellSize(title: "Reviews", collectionView)
        case is MovieRecommendationsModel:
            return DetailRecommendationsCell.getCellSize(collectionView: collectionView)
        default:
            return .zero
        }
    }
    
    func appendReviewItems(reviews: [ReviewModel]) {
        guard !reviews.isEmpty else { return }
        items.append(MovieReviewsModel(id: item.id ?? 0,
                                       title: "Movie reviews",
                                       reviews: reviews))
    }
    
    func appendRecommendationItems(recomendations: [MovieModel]) {
        guard !recomendations.isEmpty else { return }
        items.append(MovieRecommendationsModel(id: item.id ?? 0,
                                               title: "Recommendations",
                                               recommendations: recomendations))
    }
}
