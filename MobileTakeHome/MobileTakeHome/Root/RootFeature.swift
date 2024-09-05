//
//  RootFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    struct State: Equatable {
        var albumsTab: AlbumsFeature.State
        var favoritesTab: FavoritesFeature.State
        var selectedTab: Tab = .albums
        @Shared(.favorites) var favorites
    }
    enum Action {
        case albumsTab(AlbumsFeature.Action)
        case favoritesTab(FavoritesFeature.Action)
        case selectedTabChanged(Tab)
    }
    
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
        Scope(state: \.albumsTab, action: \.albumsTab) {
            AlbumsFeature()
        }
        Scope(state: \.favoritesTab, action: \.favoritesTab) {
            FavoritesFeature()
        }
    }
}
