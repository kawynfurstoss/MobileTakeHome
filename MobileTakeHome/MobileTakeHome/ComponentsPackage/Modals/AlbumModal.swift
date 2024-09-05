//
//  AlbumModal.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct AlbumModal: View {
    var album: Album?
    var isFavorite: Bool
    var onViewGalleryTapped: () -> Void
    var onFavoriteTapped: (Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Album Contains \(album!.images.count) images")
                        .font(.subheadline)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blue.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    Text(album?.title ?? "")
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the text can expand to fit the container
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .lineLimit(nil)
                    if let description = album?.description {
                        Text(description)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the text can expand to fit the container
                            .foregroundColor(.black)
                            .font(.title3)
                            .lineLimit(4)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the text can expand to fit the container
                Spacer()
                FavoriteButton(isFavorite: isFavorite) { isFavorited in
                    onFavoriteTapped(isFavorited)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            VStack {
                CapsuleButton(label: "View Album") {
                  onViewGalleryTapped()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .padding(.bottom, Padding.large)
        }
    }
}

