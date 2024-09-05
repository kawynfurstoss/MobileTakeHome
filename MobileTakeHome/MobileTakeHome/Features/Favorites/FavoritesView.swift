//
//  FavoritesView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI
import ComposableArchitecture

struct FavoritesView: View {
    let store: StoreOf<FavoritesFeature>
    @State private var selectedSegment = 0
    let segments = ["Albums", "Images"]
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 2
            VStack {
                Picker("Select a view", selection: $selectedSegment) {
                    ForEach(0..<segments.count) { index in
                        Text(segments[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // View Content Based on Selection
                if selectedSegment == 0 {
                    VStack {
                        Text("Album Favorites")
                        SquareGridView(items: store.favorites.albumFavorites.elements, columns: 2, columnWidth: width) { album in
                            if let image = album.images.first?.imageLink {
                                if let imageUrl = URL(string: image) {
                                    AsyncThumbnailView(url: imageUrl, width: width)
                                        .onTapGesture {
                                            // TODO: Implement Display Albums
                                        }
                                }
                            }
                        }
                        Spacer()
                    }
                } else {
                    VStack {
                        Text("Image Favorites")
                        SquareGridView(items: store.favorites.imageFavorites.elements, columns: 2, columnWidth: width) { image in
                            if let imageUrl = URL(string: image.imageLink) {
                                AsyncThumbnailView(url: imageUrl, width: width)
                                    .onTapGesture {
                                        // TODO: Implement Display Albums
                                    }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        
    }
}
