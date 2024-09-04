//
//  MobileTakeHomeApp.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct MobileTakeHomeApp: App {
    @State private var isDataLoaded = false
    @State private var initialAlbums = IdentifiedArrayOf<Album>()
    
    /// Dependencies required on startup
    @Dependency(\.albumService) var albumService
    
    var body: some Scene {
        WindowGroup {
            if isDataLoaded {
                RootView(store: Store(initialState: RootFeature.State(albums: AlbumsFeature.State(albums: initialAlbums)))
                         { RootFeature() })
            } else {
                ProgressView("Loading...") // Show a loading indicator
                    .task {
                        do {
                            initialAlbums = try await albumService.fetchRandomAlbums()
                            isDataLoaded = true
                        } catch {
                            // TODO: Implement Error Handling
                        }
                    }
            }
        }
    }
}
