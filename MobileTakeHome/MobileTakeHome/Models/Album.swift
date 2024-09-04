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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        link = try container.decode(String.self, forKey: .link)
        images = try container.decode(IdentifiedArrayOf<AlbumImage>.self, forKey: .images)
    }
    
    init(id: String, link: String, images: IdentifiedArrayOf<AlbumImage>) {
        self.id = id
        self.link = link
        self.images = images
    }
}
