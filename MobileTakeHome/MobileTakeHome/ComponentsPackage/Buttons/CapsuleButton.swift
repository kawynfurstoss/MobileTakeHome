//
//  CapsuleButton.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/3/24.
//

import SwiftUI

struct CapsuleButton: View {
    var label: String
    var onTapped: () -> Void

    var body: some View {
        Button(action: {
            onTapped()
        }) {
                Text(label)
                .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding()
        }
        .frame(maxWidth: .infinity)
    }
}
