//
//  FavoriteButton.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct FavoriteButton: View {
    var isFavorite: Bool
    var size: CGFloat = 50.0
    var onTapped: (Bool) -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                onTapped(!isFavorite)
            }) {
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}
