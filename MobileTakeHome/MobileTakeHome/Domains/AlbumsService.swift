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
