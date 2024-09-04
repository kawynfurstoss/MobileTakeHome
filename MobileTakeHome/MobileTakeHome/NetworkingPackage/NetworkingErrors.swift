//
//  NetworkingErrors.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

enum NetworkingError: Error {
    case invalidResponse
    case decodingFailed
    case custom(String)
}
