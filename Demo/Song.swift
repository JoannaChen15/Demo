//
//  Song.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/19.
//

import Foundation

// MARK: - Song
struct Song: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let artistName: String
    let trackName: String
    let artistViewURL, collectionViewURL, trackViewURL, previewURL: URL?
    let artworkUrl30, artworkUrl60, artworkUrl100: URL
    let releaseDate: Date
}
