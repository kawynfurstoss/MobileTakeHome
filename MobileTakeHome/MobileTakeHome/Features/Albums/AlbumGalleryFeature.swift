//
//  AlbumGalleryFeature.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import ComposableArchitecture


@Reducer
struct AlbumGalleryFeature {
  @ObservableState
  struct State: Equatable {
    var album: Album
    @Shared(.favorites) var favorites
  }
  enum Action {
      case imageAddedToFavorites(String)
      case imageRemovedFromFavorites(String)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .imageAddedToFavorites(id):
          state.favorites.imageFavorites.append(id)
          return .none
      case let .imageRemovedFromFavorites(id):
          state.favorites.imageFavorites.removeAll(where: { str in
          id == str
          })
          return .none
      }
    }
  }
}
