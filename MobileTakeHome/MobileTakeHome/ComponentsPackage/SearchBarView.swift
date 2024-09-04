//
//  SearchBarView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @State var text: String = ""
    var onSearch: (String) -> Void

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(.leading, Padding.extraLarge)
                .padding(.vertical, Padding.small)
                .background(Color(.systemGray6))
                .cornerRadius(Padding.large)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, Padding.small)
                        
                        Spacer()
                        
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, Padding.small)
                            }
                        }
                    }
                )
                .onSubmit {
                    onSearch(text)
                }
                .submitLabel(.search)
        }
        .padding(.horizontal)
    }
}
