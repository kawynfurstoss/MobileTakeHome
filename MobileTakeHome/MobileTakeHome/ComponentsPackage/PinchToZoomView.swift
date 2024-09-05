//
//  PinchToZoomView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation
import SwiftUI

struct PinchToZoomView: View {
    
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    
    @State private var isZoomed: Bool = false
    @State private var currentScale: CGFloat = 1.0     // Current zoom scale
    @State private var finalScale: CGFloat = 1.0       // Final zoom scale after pinch
    @State private var offset: CGSize = .zero          // Position offset for dragging
    @State private var lastOffset: CGSize = .zero      // Last offset position

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Color.black.edgesIgnoringSafeArea(.all) // Full-screen background

                if let uiImage = image {
                    Image(uiImage: uiImage) // Replace with your image
                        .resizable()
                        .aspectRatio(contentMode: isZoomed ? .fill : .fit)
                        .scaleEffect(max(currentScale * finalScale, 1.0)) // Ensure scale does not go below 1.0
                        .offset(x: offset.width, y: offset.height)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    currentScale = value
                                    if currentScale * finalScale > 1 {
                                        isZoomed = true // Enter full-screen when zooming
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.easeOut) {
                                        currentScale = 1.0
                                        finalScale = 1.0
                                        isZoomed = false
                                        offset = .zero
                                        lastOffset = .zero
                                    }
                                }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if isZoomed {
                                        offset = CGSize(width: lastOffset.width + value.translation.width,
                                                        height: lastOffset.height + value.translation.height)
                                    }
                                }
                                .onEnded { value in
                                    lastOffset = offset
                                }
                        )
                }
                

                
            }
            

        }
        .animation(.easeInOut, value: isZoomed)
        .onAppear {
            Task {
                await loadImage()
            }
        }
    }
    
    
    private func loadImage() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                self.image = uiImage
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        self.isLoading = false
    }
}
