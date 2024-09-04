//
//  AlbumsService.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import Dependencies
import IdentifiedCollections

@MainActor
struct AlbumService {
    /// Returns an array of Albums.
    ///
    /// Performs a query to a data provider using a specified term to return an array of Album matched with that term.
    ///
    /// - Parameters:
    ///   - queryText: The String passed into the query request.
    /// - Returns: An IdentifiedArrayOf Album.
    /// - Throws: An error if the request fails.
    var queryAlbums: @Sendable (_ queryText: String) async throws -> IdentifiedArrayOf<Album>
    
    /// Returns an array of Random Albums.
    ///
    /// Performs a request to a data provider to return an array of random Album.
    ///
    /// - Parameters:
    ///   - queryText: The String passed into the query request.
    /// - Returns: An IdentifiedArrayOf Album.
    /// - Throws: An error if the request fails.
    var fetchRandomAlbums: @Sendable () async throws -> IdentifiedArrayOf<Album>
}

extension AlbumService: DependencyKey {
  static let liveValue = Self(
    queryAlbums: { query in
      return AlbumsServiceMockData.mockData
  },
    fetchRandomAlbums: {
        return AlbumsServiceMockData.mockData
    })
    
  static let previewValue = Self(
    queryAlbums: { query in
      return AlbumsServiceMockData.mockData
  },
    fetchRandomAlbums: {
        return AlbumsServiceMockData.mockData
    })
    
    static let testValue = Self(
        queryAlbums: unimplemented("AlbumService.queryAlbums"),
        fetchRandomAlbums: unimplemented("AlbumService.fetchInitialAlbums"))
}


extension DependencyValues {
  var albumService: AlbumService {
    get { self[AlbumService.self] }
    set { self[AlbumService.self] = newValue }
  }
}

class AlbumsServiceMockData {
    static var mockData: IdentifiedArrayOf<Album> {
        // Sample data
        let albumImages: [AlbumImage] = [
          AlbumImage(id: "1", imageLink: "https://picsum.photos/200/300"),
          AlbumImage(id: "2", imageLink: "https://picsum.photos/200/300")
        ]
        let albums: [Album] = [
          Album(id: "1", link: "example.com", images: IdentifiedArrayOf(uniqueElements: albumImages)),
          Album(id: "2", link: "example.com", images: IdentifiedArrayOf(uniqueElements: albumImages)),
          Album(id: "3", link: "example.com", images: IdentifiedArrayOf(uniqueElements: albumImages))
        ]

        // Creating an IdentifiedArray from the array
        let identifiedAlbums = IdentifiedArrayOf(uniqueElements: albums)
        return identifiedAlbums
    }
}
