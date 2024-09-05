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
    
    @State var isFavorite: Bool = true
    var body: some View {
        VStack {
            Text("Favorites View")
                .font(.title)
        }
    }
}
