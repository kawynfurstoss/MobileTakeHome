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
      case imageAddedToFavorites(AlbumImage)
      case imageRemovedFromFavorites(AlbumImage)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .imageAddedToFavorites(image):
          state.favorites.imageFavorites.append(image)
          return .none
      case let .imageRemovedFromFavorites(image):
          state.favorites.imageFavorites.removeAll(where: { img in
              image == img
          })
          return .none
      }
    }
  }
}
