//
//  AlbumGalleryView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI
import ComposableArchitecture

struct AlbumView: View {
    let store: StoreOf<AlbumGalleryFeature>
    
  var body: some View {
      VStack {
          Text("\(store.state.album.title ?? "null")")
              .font(.title)
          Spacer()
      }
  }
}
