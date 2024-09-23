//
//  SearchResponse.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import Foundation

struct SearchResponse: Codable, Hashable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable, Hashable {
    let supportedDevices: [String]
    let screenshotUrls: [String]
    let minimumOsVersion: String
    
    let artworkUrl100: String
    
    let artistId: Int
    let artistName: String
    let genres: [String]

    let description: String
    
    let releaseNotes: String?
    let price: Double?
    
    let currentVersionReleaseDate: String
    let bundleId: String
    let trackName: String
    
    let averageUserRating: Double
    let userRatingCount: Int
}

extension SearchResult: CellModelConvertible {
    typealias classType = SearchResultCell
}

extension SearchResult {
    static func testObject(trackName: String) -> SearchResult {
        return SearchResult(supportedDevices: [],
                            screenshotUrls: [],
                            minimumOsVersion: "",
                            artworkUrl100: "",
                            artistId: 0,
                            artistName: "",
                            genres: [],
                            description: "",
                            releaseNotes: "",
                            price: nil,
                            currentVersionReleaseDate: "",
                            bundleId: "",
                            trackName: trackName,
                            averageUserRating: 0,
                            userRatingCount: 0)
    }
}
