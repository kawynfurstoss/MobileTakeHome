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
    
    @MainActor
    static let store = Store(initialState: RootFeature.State(albums: AlbumsFeature.State()))
    { RootFeature() }
    
    var body: some Scene {
        WindowGroup {
            if isDataLoaded {
                RootView(store: Self.store)
            } else {
                ProgressView("Loading...") // Show a loading indicator
                    .task {
                        Self.store.send(.albums(.queryAlbums("cats")))
                        isDataLoaded = true
                    }
            }
        }
    }
}
