//
//  Favorites.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import IdentifiedCollections

struct Favorites: Codable, Equatable {
    var albumFavorites: IdentifiedArrayOf<Album>
    var imageFavorites: IdentifiedArrayOf<AlbumImage>
}
