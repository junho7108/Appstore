//
//  SearchResponse.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import Foundation

struct SearchResponse: Codable {
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
    
    let price: Double
    
    let description: String
    let releaseNotes: String
    
    let currentVersionReleaseDate: String
    let bundleId: String
    let trackName: String
}
