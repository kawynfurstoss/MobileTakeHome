//
//  AsyncThumbnailView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation
import SwiftUI
import AVFoundation



struct AsyncThumbnailView: View {
    let url: URL
    let width: CGFloat
    let borderWidth: CGFloat = 2
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                switch FileType.typeForUrl(url) {
                case .jpeg, .png:
                    if let uiImage = image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width)
                    } else {
                        Text("Failed to load image")
                            .lineLimit(nil)
                            .frame(width: width, height: width, alignment: .center)
                    }
                case .mp4:
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width, alignment: .center)
                    }
                case .gif:
                    // Placeholder for GIF handling
                    Text("GIFs are not supported in this example")
                case .unknown:
                    Text("Unsupported file type")
                }
            }
        }
        .frame(width: width, height: width, alignment: .center)
        .aspectRatio(contentMode: .fill)
        .scaledToFill()
        .clipped()
        .overlay(
            Rectangle()
                .stroke(Color.black, lineWidth: borderWidth)
        )
        .onAppear {
            Task {
                switch FileType.typeForUrl(url) {
                case .jpeg, .png:
                    await loadImage()
                case .mp4:
                    await loadVideo()
                case .gif:
                    await loadImage()
                case .unknown:
                    await loadImage()
                }
            }
        }
    }
    
    private func loadVideo() async {
        do {
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            let time = CMTime(seconds: 1, preferredTimescale: 600)
            let imageRef = try await imageGenerator.image(at: time)
            self.image = UIImage(cgImage: imageRef.image)
        } catch {
            print("Error generating thumbnail: \(error)")
            self.image = nil
        }
        self.isLoading = false
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
