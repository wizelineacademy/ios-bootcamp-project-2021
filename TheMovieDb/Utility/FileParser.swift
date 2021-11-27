//
//  FileParser.swift
//  TheMovieDbTests
//
//  Created by Misael Chávez on 23/11/21.
//

import Foundation

struct FileParser {

    /// Decodes a local JSON file into the corresponding entity.
    /// - Parameter filename: The name of the local JSON file.
    /// - Throws: Can throw a serialization error or a decoding error.
    /// - Returns: The entity encoded in the JSON file.
    static func createMockResponse<R: Decodable>(filename: String) throws -> R {
        let jsonData = try FileParser.parseLocalJSONFile(filename: filename)
        let decoder = JSONDecoder()
        let response = try decoder.decode(R.self, from: jsonData)
        return response
    }

    // MARK: - Private methods

    /// Parses a locally sourced JSON file and decodes the data.
    /// - Parameter filename: The name of the JSON file.
    /// - Throws: Can throw a serialization error if the JSON is not valid.
    /// - Returns: The data object that results from the serialization.
    private static func parseLocalJSONFile(filename: String) throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw APIError.jsonConversionFailure
        }

        let data = try Data(contentsOf: fileURL)
        return data
    }
}
