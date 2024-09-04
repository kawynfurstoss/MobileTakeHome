//
//  ImgurAPI.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation

enum ImgurAPI: APIEndpoint {
    case queryAlbums(query: String)
    case getGallery
    
    var url: URL {
        switch self {
        case .queryAlbums(let query):
            return URL(string: "https://api.imgur.com/3/gallery/search?q_all=\(query)&q_type=album")!
        case .getGallery:
            return URL(string: "https://api.imgur.com/3/gallery/")!
        }
    }

    var method: String {
        switch self {
        case .queryAlbums, .getGallery:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .queryAlbums, .getGallery:
            if let unwrappedID = ProcessInfo.processInfo.environment["IMGUR_API_CLIENT_ID"] {
                return ["Authorization": "Client-ID \(unwrappedID)"]
            }
            return nil
        }
    }
}
