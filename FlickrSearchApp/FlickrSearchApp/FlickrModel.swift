//
//  FlickrModel.swift
//  FlickrSearchApp
//
//  Created by Mukesh Nethi on 11/19/24.
//

import Foundation

// Represents a single image item from the API
struct FlickrItem: Decodable, Identifiable {
    let id = UUID() // Unique identifier for SwiftUI views
    let title: String
    let media: [String: String]
    let author: String
    let published: String
    let description: String

    // Extract the image URL from the "media" field
    var imageUrl: URL? {
        URL(string: media["m"] ?? "")
    }
}

// Represents the overall response structure
struct FlickrAPIResponse: Decodable {
    let items: [FlickrItem]
}
