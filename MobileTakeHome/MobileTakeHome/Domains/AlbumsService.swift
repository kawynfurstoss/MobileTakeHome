//
//  AlbumsService.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import Dependencies
import IdentifiedCollections

/// A service primarily used for querying and fetching albums
///
/// Acts as a bridge between the State layer of the user interface, (i.e. `Reducer` & `SwiftUI`) and the data source.
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

/// Conforms to the `DependencyKey` protocol.
///
/// Determines what value of `AlbumService` is used during specific builds
extension AlbumService: DependencyKey {
    
    /// Used during simulator and device builds, makes an actual network request.
    static var liveValue: Self {
        @Dependency(\.networkingClient) var networkingClient
        return Self(
            queryAlbums: { query in
                guard let response = try await networkingClient.send(ImgurAPI.queryAlbums(query: query), AlbumsResponse.self) as? AlbumsResponse else {
                    throw NetworkingError.decodingFailed
                }
                return response.albums
            },
            fetchRandomAlbums: {
                guard let response = try await networkingClient.send(ImgurAPI.getGallery, AlbumsResponse.self) as? AlbumsResponse else {
                    throw NetworkingError.decodingFailed
                }
                return response.albums
            })
    }
    
    /// Used during swiftUI preview builds [WIP].
    static let previewValue = Self(
        queryAlbums: { query in
            return AlbumsServiceMockData.mockData
        },
        fetchRandomAlbums: {
            return AlbumsServiceMockData.mockData
        })
    
    /// Used during unit and UI tests, can be overridden within the test to return expected value.
    static let testValue = Self(
        queryAlbums: unimplemented("AlbumService.queryAlbums"),
        fetchRandomAlbums: unimplemented("AlbumService.fetchInitialAlbums"))
}

/// An extension on `DependencyValues` in order to expose a computed property for the dependency
extension DependencyValues {
    var albumService: AlbumService {
        get { self[AlbumService.self] }
        set { self[AlbumService.self] = newValue }
    }
}

/// A mock data class containing data relevent to the return method `AlbumService.queryAlbums`
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
