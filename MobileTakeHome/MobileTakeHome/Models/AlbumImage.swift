//
//  AlbumImage.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

struct AlbumImage: Identifiable, Equatable, Codable  {
    var id: String
    var imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageLink = "link"
    }
}
