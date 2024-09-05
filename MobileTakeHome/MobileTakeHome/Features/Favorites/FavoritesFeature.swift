//
//  FavoritesFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import ComposableArchitecture


@Reducer
struct FavoritesFeature {
  @ObservableState
  struct State: Equatable {
    @Shared(.favorites) var favorites
  }
  enum Action {

  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      }
    }
  }
}
