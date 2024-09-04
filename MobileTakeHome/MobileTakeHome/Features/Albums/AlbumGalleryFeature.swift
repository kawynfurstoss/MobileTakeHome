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
    let album: Album
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
