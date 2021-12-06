//
//  APIService.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation
import Combine

struct APIService: APIMoviesProtocol { 
    
    func fetchData<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters) -> AnyPublisher<T, APIRequestError> {
        let  urlBuild = APIUrlBuilder(with: parameters, with: endPoint)
        guard let url = urlBuild.buildURL() else {
            return Fail(outputType: T.self, failure: APIRequestError.badRequest).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return  URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    throw self.httpError(response.statusCode)
                }
                return data
            })
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                Log.networkLayer(error).description
                return self.handleError(error)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

private extension APIService {
    func httpError(_ statusCode: Int) -> APIRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    func handleError(_ error: Error) -> APIRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as APIRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
