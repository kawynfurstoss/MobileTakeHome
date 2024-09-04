//
//  AlbumModal.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct AlbumModal: View {
    var album: Album?
    var onViewGalleryTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Album Contains \(album!.images.count) images")
                    .font(.subheadline)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.blue.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                Text(album?.title ?? "")
                    .foregroundColor(.black)
                    .font(.title)
                    .lineLimit(3)
                Text(album?.description ?? "")
                    .foregroundColor(.black)
                    .font(.title3)
                    .lineLimit(4)
            }
            .padding(20)
            Spacer()
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

