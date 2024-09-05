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
        var albums: AlbumsFeature.State
        @Shared(.favorites) var favorites
    }
    enum Action {
        case albums(AlbumsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .albums(_):
                return .none
            }
        }
        Scope(state: \.albums, action: \.albums) {
            AlbumsFeature()
        }
    }
}
