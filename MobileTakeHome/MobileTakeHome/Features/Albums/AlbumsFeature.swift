//
//  AlbumsFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import ComposableArchitecture

@Reducer
struct AlbumsFeature {
    @ObservableState
    struct State: Equatable {
        var albums: IdentifiedArrayOf<Album>
    }
    enum Action {
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            }
        }
    }
}
