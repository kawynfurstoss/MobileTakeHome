//
//  AlbumsResponse.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import IdentifiedCollections

struct AlbumsResponse: Decodable {
    let albums: IdentifiedArrayOf<Album>
    
    enum CodingKeys: String, CodingKey {
        case albums = "data"
    }
}
