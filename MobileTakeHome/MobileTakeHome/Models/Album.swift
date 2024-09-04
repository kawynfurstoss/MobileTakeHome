//
//  Album.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import IdentifiedCollections

struct Album: Identifiable, Equatable, Codable {
    var id: String
    var title: String?
    var description: String?
    var link: String
    var images: IdentifiedArrayOf<AlbumImage>
}
