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
    
    /// Creates a single instance of the `RootFeature` `Store`, initializing child `States` as well
    @MainActor
    static let store = Store(initialState: RootFeature.State(albumsTab: AlbumsFeature.State(), favoritesTab: FavoritesFeature.State()))
    { RootFeature() }
    
    var body: some Scene {
        WindowGroup {
            if isDataLoaded {
                /// Initial View of App
                RootView(store: Self.store)
            } else {
                /// Perfoms any sort of start up tasks such as fetching data required before displaying app
                ProgressView("Loading...")
                    .task {
                        Self.store.send(.albumsTab(.queryAlbums("cats")))
                        isDataLoaded = true
                    }
            }
        }
    }
}
