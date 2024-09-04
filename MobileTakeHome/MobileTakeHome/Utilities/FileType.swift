//
//  FileType.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation

enum FileType {
    case jpeg
    case png
    case mp4
    case gif
    case unknown
}

extension FileType {
    static func typeForUrl(_ url: URL) -> FileType {
        let pathExtension = url.pathExtension.lowercased()
        switch pathExtension {
        case "jpg", "jpeg":
            return .jpeg
        case "png":
            return .png
        case "mp4":
            return .mp4
        case "gif":
            return .gif
        default:
            return .unknown
        }
    }
}


