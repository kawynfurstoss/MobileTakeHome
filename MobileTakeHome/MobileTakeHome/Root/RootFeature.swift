//
//  RootFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture

/// The main reducer of the app, responsible for handling all state changes and side effects.
///
/// The reducer is composed of smaller child reducers, each responsible for managing a specific domain of the application.
@Reducer
struct RootFeature {
    
    /**
     Corresponding `State` for `RootView`
     
     - Parameters:
        - albumsTab: Direct reference to the state of the child reducer's, `AlbumFeature` `State`.
        - favoritesTab: Direct reference to the state of the child reducer's, `FavoritesFeature` `State`.
        - selectedTab: Represents the currently selected tab for `TabView`.
        - favorites: A `@Shared` value for the `Favorites` object, this is globally shared.

     */
    @ObservableState
    struct State: Equatable {
        var albumsTab: AlbumsFeature.State
        var favoritesTab: FavoritesFeature.State
        var selectedTab: Tab = .albums
        @Shared(.favorites) var favorites
    }
    
    /// Represents the available actions for the `RootView`.
    ///
    /// Use this enum to handle any sort of action to be taken in `RootView`.
    enum Action {
        case albumsTab(AlbumsFeature.Action)
        case favoritesTab(FavoritesFeature.Action)
        case selectedTabChanged(Tab)
    }
    
    /// This reducer takes in the app's state and actions, processes them, and returns a new state or effect.
    /// It is the primary entry point for all state updates in the application.
    ///
    /// - Parameters:
    ///   - state: The current state of the application. Passed as an `inout` parameter so it can be mutated.
    ///   - action: An action that represents user input, external events, or other changes that affect the app's state.
    /// - Returns: A combination of the updated state and any side effects, encapsulated in an `Effect`.
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .albumsTab(_):
                return .none
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
            }
        }
        /// Scopes the `Root` reducer to a smaller child feature of `Albums` & `Favorites`, isolating its state and actions.
        Scope(state: \.albumsTab, action: \.albumsTab) {
            AlbumsFeature()
        }
        Scope(state: \.favoritesTab, action: \.favoritesTab) {
            FavoritesFeature()
        }
    }
}
